"""Wrappers for interactions with the homebrew package manager"""
import json
import re
import logging
import subprocess

from operator import itemgetter
from bisect import bisect_left
from urllib.request import urlopen
from .utils import BinaryDependent


def _matches_versioned_package_name(unversioned_name, versioned_name):
    pattern = r"^{%s}@\d+(\.\d+)?(\.\d+)?$" % unversioned_name
    return re.match(pattern, versioned_name) is not None


class Homebrew(BinaryDependent, binary="brew", platform="darwin"):
    """Wraps `brew` so that cask, and non-cask dependencies can be queried for
    """

    @classmethod
    def installedNonCaskDeps(cls):
        """Find what was installed through homebrew
        This finds the leaves in the inverse dependency graph
        """
        logging.info("Reading `brew` installations")
        cmd = [cls.binary, "info", "--installed", "--json"]
        with subprocess.Popen(cmd, encoding="utf-8", stdout=subprocess.PIPE, stderr=subprocess.PIPE) as proc:
            proc.returncode
            alL_metadata = json.load(proc.stdout)
            explicitly_installed_packages = set()
            for pkgmeta in alL_metadata:
                if len(pkgmeta["installed"]) != 1:
                    raise RuntimeError(
                        "Expected exactly 1 element in 'installed' " "section for package %s", pkgmeta["name"],
                    )
                if pkgmeta["installed"][0]["installed_on_request"]:
                    name = pkgmeta["name"]
                    # Check if there is a versioned alias available, if so use that
                    # So as to not cause accidental upgrades when installing after a
                    # break
                    for alias in pkgmeta["aliases"]:
                        if _matches_versioned_package_name(name, alias):
                            name = alias
                            break
                    explicitly_installed_packages.add(name)
            return explicitly_installed_packages

    @classmethod
    def installedCaskDeps(cls):
        roots = set()
        logging.info("Reading `brew cask` installations")
        # This is simpler because `brew cask list` only seems to list explicitly
        # installed packages
        outputLines = subprocess.run([cls.binary, "cask", "list"], check=True, capture_output=True, encoding="utf-8",).stdout
        if not outputLines:
            return roots
        # brew cask list uses its own format
        outputLines = outputLines.split()
        roots.update(outputLines)
        logging.currentframe
        return roots

    @classmethod
    def find(cls, *packages):
        if not packages:
            return None
        with urlopen("https://formulae.brew.sh/api/cask.json") as response:
            all_casks = json.load(fp=response)
            cls.cask_names = sorted(map(itemgetter("token"), all_casks))
        with urlopen("https://formulae.brew.sh/api/formula.json") as response:
            all_formulae = json.load(fp=response)
            cls.formula_names = sorted(map(itemgetter("name"), all_formulae))

        results = {"cask": [], "formula": []}
        for package in packages:
            idx = bisect_left(cls.cask_names, package)
            if idx:
                results["cask"].append(package)
            else:
                idx = bisect_left(cls.formula_names, package)
                if idx:
                    results["formula"].append(package)
                else:
                    raise RuntimeError("Unable to locate '%s' on brew!")

    @classmethod
    def deps(cls, extra_packages=None):
        formula_deps = cls.installedNonCaskDeps()
        cask_deps = cls.installedCaskDeps()
        packages_to_find = set(extra_packages) - (formula_deps | cask_deps)
        extra_deps = cls.find(*packages_to_find)
        if extra_deps:
            formula_deps.update(extra_deps["formula"])
            cask_deps.update(extra_deps["cask"])
        return {
            "formulae": list(sorted(formula_deps)),
            "casks": list(sorted(cask_deps)),
        }
