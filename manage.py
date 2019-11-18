#!/usr/bin/env python3

import sys
from argparse import ArgumentParser, Namespace

# This controls where which file or directory goes
DESTINATIONS = {
    "nvim": "~/.config/nvim",
    "fish": "~/.config/fish",
    "stack": "~/.config/stack",
    "gitconfig": "~/.gitconfig",
}


def installFiles():
    """Install our dotfiles to their respective locations"""
    pass


def backupFiles():
    """Back up our dotfiles from their respective locations"""
    pass


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
