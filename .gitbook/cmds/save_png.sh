#!/usr/bin/env bash

set -e
set -o pipefail

uuid_file="$(echo $(uuidgen) | tr '[:upper:]' '[:lower:]').png"
save_file=".gitbook/assets/${uuid_file}"
pngpaste ${save_file}

echo "file is save to file: ${save_file}"
echo ${save_file} | pbcopy
