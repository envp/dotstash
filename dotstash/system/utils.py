"""Wrappers around interactions with the shell"""
import os
import sys
import shlex
import shutil
import logging
import subprocess


class BinaryDependent:
    """Metaclass whose instances are classes representing an executable binary 
    available on $PATH"""

    def __init_subclass__(cls, binary=None, platform=None, **kwargs):
        super().__init_subclass__(**kwargs)
        if not platform:
            raise RuntimeError("Platform must be specified")
        if not binary:
            raise RuntimeError("Binary to wrap must be specified")
        if platform not in sys.platform:
            raise RuntimeError(f"Incompatible platform: `{platform}`")
        if hasattr(cls, "binary"):
            raise ValueError("Attribute `binary` already in use")
        executable = shutil.which(binary)
        if not executable:
            raise RuntimeError(f"Exectuable `{executable}` not found $PATH")
        setattr(cls, "binary", executable)


def file_iterator(root_dir, topdown=True):
    """Create an iterator wrapping `os.walk` to traverse all files under a
    given directory"""
    for current_root, dirs, files in os.walk(root_dir, topdown=topdown):
        absoulte_root = os.path.abspath(current_root)
        for file_ in files:
            yield os.path.join(absoulte_root, file_)
