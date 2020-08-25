import os
import sys
import json
import yaml
import logging
import argparse
import enum

from datetime import datetime

from . import system
from .system.app_manifest import Manifest


class ReadManifest(argparse.Action):
    def __init__(self, option_strings, dest, **kwargs):
        super().__init__(option_strings, dest, **kwargs)

    def __call__(self, _parser, namespace, values, _option_strings):
        if manifest := getattr(namespace, self.dest):
            # Check for collisions with the existing manifest,
            # This happens under t
            for path in values:
                with open(path) as stream:
                    manifest.merge(Manifest.from_yaml(stream))
            setattr(namespace, self.dest, manifest)
        else:
            manifest = Manifest()
            for path in values:
                with open(path) as stream:
                    manifest.merge(Manifest.from_yaml(stream))
            setattr(namespace, self.dest, manifest)


def configure_parser(**kwargs):
    parser = argparse.ArgumentParser(**kwargs)
    subparsers = parser.add_subparsers(help="Available subcommands")
    backup_parser = subparsers.add_parser(
        "backup", help="Backup dotfiles to a given location"
    )
    backup_parser.add_argument(
        "--manifest",
        action=ReadManifest,
        nargs="+",
        help="Paths to files that specify package names "
        "and associated files to backup",
    )
    backup_parser.set_defaults(backup=True)
    install_parser = subparsers.add_parser(
        "install", help="Install dotfiles from a given bundle"
    )
    install_parser.set_defaults(install=True)
    return parser


def parse_args(args, **kwargs):
    parser = configure_parser(**kwargs)
    logging.debug("Parsing args=%s, kwargs=%s", args, kwargs)
    return parser.parse_args(args)


if __name__ == "__main__":
    logging.basicConfig(
        format="%(asctime)s|%(levelname)-8s|%(message)s|",
        level=os.getenv("PYTHON_LOGLEVEL", "INFO"),
    )
    args = parse_args(sys.argv[1:], prog="dotstash")
    if args.backup:
        dependencies = {
            "timestamp": datetime.now().astimezone().strftime("%Y%m%dT%H%M%S%z"),
        }
        # Fetch all installed system packages first, followed by adding the
        # packages for which a file manifest was provided
        dependencies.update(system.installedPackages(extra_manifest=args.manifest))

        yaml.dump(dependencies, stream=sys.stdout)
    elif args.install:
        raise NotImplementedError()
