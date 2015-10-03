#!/bin/bash
set -e
cd "$(dirname $0)"
cd "$(pwd -P)"

exec ../create-all-packages.py -u insideo -a ~/.bintray/apikey -o insideo -p ../manifest.yml
