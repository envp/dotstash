"""Wrappers around interactions with the shell"""
import sys
import shlex
import shutil
import logging
import subprocess

class ShellCommand:
    """An executable command on the shell"""
    def __init__(self, cmd):
        self.cmd = [shlex.quote(c) for c in cmd]
    
    def __str__(self):
        return " ".join(self.cmd)
    
    def run(self):
        try:
            proc = subprocess.run(self.cmd, capture_output=True,
                                  encoding="utf-8", check=True)
            return proc.stdout
        except subprocess.CalledProcessError as exc:
            logging.fatal("Command '%s' failed. STDERR: %s", self, exc.stderr)
            return None


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
        if hasattr(cls, 'binary'):
            raise ValueError("Attribute `binary` already in use")
        executable = shutil.which(binary)
        if not executable:
            raise RuntimeError(f"Exectuable `{executable}` not found $PATH")
        setattr(cls, 'binary', executable)
