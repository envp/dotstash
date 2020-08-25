"""Various tests for the interface for the
``dotstash.system.app_manifest.Manifest`` object. These include"""
import os
import io
import pytest

from textwrap import dedent
from unittest.mock import patch
from dotstash.system.app_manifest import Manifest


def fake_os_path_isdir(path):
    return path.rstrip("/").endswith(".d")


def fake_file_iterator(path):
    return [os.path.join(path, f) for f in ["a", "b", "c"]]


@patch("os.path.isfile", return_value=True)
@patch("os.path.isdir", new=fake_os_path_isdir)
@patch("dotstash.system.app_manifest.file_iterator", new=fake_file_iterator)
def test_manifest_parses_well_formed_input(*_args):
    """If a Manifest object is provided a malformed object to read YAML from,
    it will raise a ``ValueError``"""
    # Given
    stream = io.StringIO(
        dedent(
            """\
    - pkg_1:
        - ~/.config/path/to/config.file
        - ~/.config/path/to/dir.d
    - pkg_2:
        - ~/.pkg_2.conf
    - pkg_3:
        - ~/.local/share/pkg_3.yml
    """
        )
    )
    # When
    manifest = Manifest.from_yaml(stream)
    # Then
    assert 3 == len(manifest.bundles)
    assert ["pkg_1", "pkg_2", "pkg_3"] == list(manifest.bundles.keys())


@patch("os.path.isfile", return_value=True)
@patch("os.path.isdir", new=fake_os_path_isdir)
@patch("dotstash.system.app_manifest.file_iterator", new=fake_file_iterator)
def test_manifest_error_when_root_is_not_a_list(*_args):
    """If a Manifest object is provided a malformed object to read YAML from,
    it will raise a ``ValueError``"""
    # Given
    stream = io.StringIO(
        dedent(
            """\
    pkg_1:
      - ~/.config
      - ~/.config/path/to/dir.d
    pkg_2:
      - ~/.pkg_2.conf
    pkg_3:
      - ~/.local/share/pkg_3.yml
    """
        )
    )
    with pytest.raises(ValueError):
        Manifest.from_yaml(stream)


@patch("os.path.isfile", return_value=True)
@patch("os.path.isdir", new=fake_os_path_isdir)
@patch("dotstash.system.app_manifest.file_iterator", new=fake_file_iterator)
def test_manifest_error_when_list_items_are_not_a_kv_pairs(*_args):
    """If a Manifest object is provided a malformed object to read YAML from,
    it will raise a ``ValueError``"""
    # Given
    stream = io.StringIO(
        dedent(
            """\
    - pkg_1
    - pkg_2
    - pkg_3
    """
        )
    )
    with pytest.raises(ValueError):
        Manifest.from_yaml(stream)


def test_manifest_error_when_item_values_are_not_lists():
    """If a Manifest object is provided a malformed object to read YAML from,
    it will raise a ``ValueError``"""
    # Given
    stream = io.StringIO(
        dedent(
            """\
    - pkg_1: ~/.config/path/to/config.file
    - pkg_2: ~/.pkg_2.conf
    - pkg_3: ~/.local/share/pkg_3.yml
    """
        )
    )
    with pytest.raises(ValueError):
        Manifest.from_yaml(stream)


def test_manifest_error_on_repeated_section():
    """If a Manifest object is provided a malformed object to read YAML from,
    it will raise a ``ValueError``"""
    # Given
    stream = io.StringIO(
        dedent(
            """\
    - nvim:
        - ~/.config/nvim/init.vim
        - ~/.config/nvim/ftdetect
    - tmux:
        - ~/.tmux.conf
    - nvim:
        - ~/.config/alacritty/alacritty.yml
    """
        )
    )
    with pytest.raises(ValueError):
        Manifest.from_yaml(stream)
