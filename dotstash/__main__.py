import os
import sys
import json
import yaml
import logging
import argparse
import enum

from datetime import datetime, timezone

from . import system


def parse_args(args, **kwargs):
    logging.debug('Parsing args=%s, kwargs=%s', args, kwargs)
    parser = argparse.ArgumentParser(**kwargs)
    group = parser.add_mutually_exclusive_group()
    group.add_argument(
        '--backup', type=argparse.FileType('w'), nargs='?', metavar='PATH',
        action='store', default='-',
        help="Backup dotfiles and system configuration to given path")
    group.add_argument(
        '--install', type=argparse.FileType('r'), nargs=1, metavar='PATH',
        help="Install dotfiles and system configuration from given path")
    parser.add_argument('--config')
    return parser.parse_args(args)


if __name__ == '__main__':
    logging.basicConfig(
        format="%(asctime)s|%(levelname)-8s|%(message)s|",
        level=os.getenv('PYTHON_LOGLEVEL', 'INFO')
    )
    args = parse_args(sys.argv[1:], prog='dotstash')
    # Fetch all the system deps as we know about them
    if args.backup:
        dependencies = {
            "timestamp": datetime.now(tz=timezone.utc).strftime("%Y%m%d%H%M%S%z"),
        }
        dependencies.update(system.installedPackages())
        yaml.dump(dependencies, stream=args.backup)
    elif args.install:
        yaml.load(stream=args.install, Loader=dict)
