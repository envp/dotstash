"""Wrappers for interactions with the homebrew package manager"""
import logging

from .cmd_utils import BinaryDependent, ShellCommand

class Homebrew(BinaryDependent, binary="brew", platform="darwin"):
    """Wraps `brew` so that cask, and non-cask dependencies can be queried for
    """
    @classmethod
    def installedNonCaskDeps(cls):
        """Find what was installed through homebrew
        This finds the leaves in the inverse dependency graph
        """
        logging.info("Reading `brew` installations")
        cmd = ShellCommand([cls.binary, "deps", "--installed"])
        roots = set()
        dependents = set()
        
        outputLines = cmd.run()
        if not outputLines:
            return roots
        outputLines = outputLines.split("\n")
        
        for line in outputLines:
            if not line:
                continue
            src, dests = line.split(":", maxsplit=1)
            for dep in dests.split():
                dependents.add(dep)
                if dep in roots:
                    roots.remove(dep)
            if src not in dependents:
                roots.add(src)
        return roots

    @classmethod
    def installedCaskDeps(cls):
        roots = set()
        logging.info("Reading `brew cask` installations")
        outputLines = ShellCommand([cls.binary, "cask", "list"]).run()
        if not outputLines:
            return roots
        # brew cask list uses its own format
        outputLines = outputLines.split()
        roots.update(outputLines) 
        logging.currentframe
        return roots
    
    @classmethod
    def deps(cls):
        return {
            "root": list(sorted(cls.installedNonCaskDeps())),
            "cask": list(sorted(cls.installedCaskDeps()))
        }
