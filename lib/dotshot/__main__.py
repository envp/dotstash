import os
import sys
import json
import logging
import argparse

from datetime import datetime, timezone

from . import system

def parse_args(args, **kwds):
    parser = argparse.ArgumentParser(*args, **kwargs)
    group = self.add_mutually_exclusive_group()
    group.add_argument(
        '--backup', type=str, nargs=1, metavar='PATH',
        help="Backup dotfiles and system configuration to given path")
    group.add_argument(
        '--install', type=str, nargs=1, metavar='PATH',
        help="Install dotfiles and system configuration from given path")
    return parser.parse_args(args)


if __name__ == '__main__':
    args = parse_args(sys.argv, prog='dotshot')
    logging.basicConfig(
        format="%(asctime)s|%(levelname)s|%(message)s",
        level=os.getenv('PYTHON_LOGLEVEL', 'INFO')
    )
    dependencies = {
        "timestamp": datetime.now(tz=timezone.utc).strftime("%Y%m%d%H%M%S%z"),
    }
    dependencies.update(system.installedPackages())
    json.dump(dependencies, fp=sys.stdout)
