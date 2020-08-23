#!/usr/bin/env bash

[[ ! -z "$DEBUG" ]] && set -ex;

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
workspace=$(mktemp -d -p "${SCRIPT_DIR}")
echo Created temporary workspace "${workspace}"

if which python3 > /dev/null 2>&1; then
    # Create a virtual environment for our deps
    python3 -m venv "${workspace}";
    source "${workspace}/bin/activate";
    # Install said deps
    pip3 install -U -I pip -r "${SCRIPT_DIR}/requirements.txt";
    # Run application with arguments given to this script
    PYTHONPATH="${SCRIPT_DIR}/lib" python3 -m dotstash "$@";
    # Deactivate environment
    deactivate;
    # Clean up
    rm -rf "${workspace}";
else
    echo No python3 found on $PATH
fi
