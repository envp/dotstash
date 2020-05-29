import sys
import logging
from enum import Enum

from . import brew


def installedPackages():
    """Return all packages that must be installed via the preferred system
    installer"""
    manifest = {"root": []}
    if sys.platform.startswith('darwin'):
        # All homebrew installations depend on `brew`
        manifest["root"].append("brew")
        manifest["brew"] = brew.Homebrew.deps()
        logging.info("Found darwin dependencies: `brew` and %s friends",
                      sum([len(v) for v in manifest["brew"].values()]))
    return manifest
