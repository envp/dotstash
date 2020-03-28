#!/usr/bin/env python3.7
import os
import sys
import shutil
import shlex
import contextlib
import logging
import subprocess

from typing import Dict
from argparse import ArgumentParser, Namespace

SCRIPT_DIR = os.path.dirname(__file__)

LOGGER = logging.getLogger(__name__)


def absolutePath(path, base=None):
    """Return the absoute"""
    return os.path.abspath(os.path.expanduser(path))


def scriptRelPath(path):
    """Return an absolute path that was relative to the script dir"""
    return os.path.abspath(os.path.join(SCRIPT_DIR, path))


def run(commandString: str):
    """Run a command in a different process"""
    cmdFragments = shlex.split(commandString)
    proc = subprocess.run(cmdFragments, check=True, encoding="utf-8")
    return (proc.stdout, proc.stderr)


# This controls where which file or directory goes
# Each Key-Value pair must be unique and invertible
INSTALL_DESTINATIONS = {
    # Vim
    scriptRelPath("./nvim"): absolutePath("~/.config/nvim"),
    # Fish
    scriptRelPath("./fish"): absolutePath("~/.config/fish"),
    # Bash
    scriptRelPath("./bash/bash"): absolutePath("~/bash"),
    scriptRelPath("./bash/bashrc"): absolutePath("~/.bashrc"),
    scriptRelPath("./bash/bash_profile"): absolutePath("~/.bash_profile"),
    scriptRelPath("./bash/bbprofile"): absolutePath("~/.bbprofile"),
    scriptRelPath("./bash/inputrc"): absolutePath("~/.inputrc"),
    # Git
    scriptRelPath("./gitconfig"): absolutePath("~/.gitconfig"),
    # GDB
    scriptRelPath("./gdbinit"): absolutePath("~/.gdbinit"),
    # tmux
    scriptRelPath("./tmux.conf"): absolutePath("~/.tmux.conf"),
    # alacritty
    scriptRelPath("./alacritty/alacritty.yml"): absolutePath(
        "~/.config/alacritty/alacritty.yml"
    ),
}

BACKUP_TARGETS = {v: k for k, v in INSTALL_DESTINATIONS.items()}


def copyFilesBySpec(spec: Dict[str, str]):
    """Copy files according to a dictionary spec that specifies (src, dest)
    pairs"""
    for src, dest in spec.items():
        if os.path.isfile(src):
            LOGGER.info("Copying file: %s -> %s", src, dest)
            with contextlib.suppress(shutil.SameFileError):
                shutil.copy2(src, dest)
        elif os.path.isdir(src):
            try:
                LOGGER.info("Copying directory: %s -> %s", src, dest)
                with contextlib.suppress(shutil.SameFileError):
                    shutil.copytree(src, dest)
            except FileExistsError:
                LOGGER.info(
                    "Destination exists, retrying after deleting destination"
                )
                shutil.rmtree(dest)
                shutil.copytree(src, dest)


def installFiles() -> None:
    """Install our dotfiles to their respective locations"""
    copyFilesBySpec(INSTALL_DESTINATIONS)


def backupFiles() -> None:
    """Back up our dotfiles from their respective locations"""
    copyFilesBySpec(BACKUP_TARGETS)


def main(opts: Namespace):
    """Application entry point"""
    if opts.install:
        installFiles()
    elif opts.backup:
        backupFiles()


def genParser() -> ArgumentParser:
    """Returns an instance of `ArgumentParser` set up to parse command line
    flags for this dotfile backup tool
    """
    parser = ArgumentParser(description="Back up dotfiles")
    actions = parser.add_mutually_exclusive_group(required=True)
    actions.add_argument(
        "--install",
        action="store_true",
        help="Install the dotfiles from this directory to "
        "their respective locations",
    )
    actions.add_argument(
        "--backup",
        action="store_true",
        help="Save the external dotfile configuration "
        "to this directory and commit to VCS",
    )
    parser.add_argument(
        "--set-cron",
        action="store_true",
        help="Create a CRON tab to run this script, if one doesn't exist",
    )
    return parser


def configureLogging():
    try:
        import coloredlogs

        coloredlogs.install(level="INFO", logger=LOGGER)
    except ModuleNotFoundError:
        print(
            "Unable to import `coloredlogs`; try: `pip3.7 install --upgrade coloredlogs`"
        )


if __name__ == "__main__":
    parser = genParser()
    configureLogging()
    main(parser.parse_args(sys.argv[1:]))
