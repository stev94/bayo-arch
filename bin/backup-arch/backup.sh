#!/bin/bash

set -ex

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$SCRIPT_DIR"/../

echo "Reading installed packages"
mkdir -p "$ROOT_DIR"/packages
pacman -Qqen > "$ROOT_DIR"/packages/from-pacman.txt
pacman -Qqem > "$ROOT_DIR"/packages/from-aur.txt
