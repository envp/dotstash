#!/usr/bin/env python3
import os
import sys
import shutil

from argparse import ArgumentParser, Namespace


def absolutePath(path):
    """Return the absoute"""
    return os.path.abspath(os.path.expanduser(path))


# This controls where which file or directory goes
# Each Key-Value pair must be unique and invertible
INSTALL_DESTINATIONS = {
    absolutePath("./nvim"): absolutePath("~/.config/nvim"),
    absolutePath("./fish"): absolutePath("~/.config/fish"),
    absolutePath("./stack"): absolutePath("~/.config/stack"),
    absolutePath("./gitconfig"): absolutePath("~/.gitconfig"),
}

BACKUP_TARGETS = {v: k for k, v in INSTALL_DESTINATIONS.items()}


def installFiles() -> None:
    """Install our dotfiles to their respective locations"""
    for src, dest in INSTALL_DESTINATIONS.items():
        if os.path.isfile(src):
            shutil.copy2(src, dest)
        elif os.path.isdir(src):
            shutil.copytree(src, dest)


def backupFiles() -> None:
    """Back up our dotfiles from their respective locations"""
    for src, dest in BACKUP_TARGETS.items():
        if os.path.isfile(src):
            shutil.copy2(src, dest)
        elif os.path.isdir(src):
            try:
                shutil.copytree(src, dest)
            except FileExistsError:
                shutil.rmtree(dest)


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


if __name__ == "__main__":
    parser = genParser()
    main(parser.parse_args(sys.argv[1:]))
