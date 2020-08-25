"""Descriptors for applications that not only need to be installed but can be
configured via files located at predetermined paths"""
import os
import collections
import typing
import yaml


from .utils import file_iterator


class AppBundle(collections.Iterable):
    """Represent an app such as `nvim`, or `tmux` etc. Where there are two
    steps to getting the system up to date:
        1. Install application
        2. Copy over config files to the intended target destination
    """

    def __init__(self, package_name: str, paths_to_save: typing.List[str]):
        """Create a new `AppBundle`

        :param package_name: Complete package name with which to associate
                             the saved paths
        :param paths_to_save:
        """
        self.pkg = package_name
        self.bundle = []
        for path in map(os.path.expanduser, paths_to_save):
            if os.path.isfile(path):
                head, tail = os.path.split(path)
                self.bundle.append((head, [tail]))
            elif os.path.isdir(path):
                files_under_dir = list(file_iterator(path))
                # Discard common prefix plus trailing slash
                common_len = len(path) + 1
                files_under_dir = map(lambda f: f[common_len:], files_under_dir)
                self.bundle.append((path, list(files_under_dir)))

    def __iter__(self):
        yield (
            self.pkg,
            [os.path.join(basedir, items[0]) if len(items) == 1 else basedir for (basedir, items) in self.bundle],
        )


class Manifest(collections.Iterable):
    """A manifest is a (possibly empty) collection of `AppBundle` objects"""

    def __init__(self, *bundles: typing.List[AppBundle]):
        self.bundles = {item.pkg: item for item in bundles}

    @staticmethod
    def from_yaml(stream: typing.TextIO):
        """Read a manifest from the given file handle"""
        manifest = Manifest()
        obj = yaml.safe_load(stream)
        if not isinstance(obj, list):
            raise ValueError("All manifests must be lists of objects")
        for item in obj:
            if not isinstance(item, dict):
                raise ValueError("All itemized objects in the manifest must be a key with " "a list of paths to save")
            for pkg, paths in item.items():
                if not isinstance(paths, list):
                    raise ValueError("Paths to save for each app MUST be " "a list")
                if pkg not in manifest.bundles:
                    manifest.bundles[pkg] = AppBundle(pkg, paths)
                else:
                    raise ValueError("Package '%s' already seen in manifest! Discard " "disjoint specifications if any!")
        return manifest

    def merge(self, other: typing.TypeVar("Manifest", bound="Manifest")):
        """Absorb the given manifest into this one with some basic error
        handling"""
        self_pkgs = self.bundles.keys()
        other_pkgs = other.bundles.keys()

        if self_pkgs.isdisjoint(other_pkgs):
            self.bundles.update(other.bundles)
        else:
            raise ValueError("Overlapping manifests cannot be merged!")

    def packages(self):
        return self.bundles.keys()

    def __iter__(self):
        return iter(self.bundles.values())
