import sys
import logging
from enum import Enum

try:
    from . import brew
except RuntimeError:

    class brew:
        class Homebrew:
            @classmethod
            def deps(extra_packages=None):
                return None


def installedPackages(extra_manifest=None):
    """Return all packages that must be installed via the preferred system
    installer"""
    manifest = {"installed_packages": []}
    if sys.platform.startswith("darwin"):
        # All homebrew installations depend on `brew`
        extra_packages = extra_manifest.packages() if extra_manifest else None
        brew_package_group = brew.Homebrew.deps(extra_packages=extra_packages)
        if brew_package_group:
            manifest["installed_packages"].append({"brew": brew_package_group})
            logging.info(
                "Found darwin dependencies: `brew` and %s friends", sum(map(len, brew_package_group)),
            )
    return manifest
