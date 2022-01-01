#!/bin/bash

set -ex

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
ROOT_DIR="$SCRIPT_DIR"/../../scripts/

mkdir -p /usr/bin/cronjobs
cp "$ROOT_DIR"/cronjobs/* /usr/bin/cronjobs/
chmod +x /usr/bin/cronjobs/*

(crontab -l; echo "0 0 * * 1 /usr/bin/cronjobs/update-mirrors.sh") | awk '!x[$0]++' | crontab -
