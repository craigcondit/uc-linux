#!/bin/bash
set -ex

cd "$(dirname $0)"
cd "$(pwd -P)"/uc-linux-buggy

docker build -t insideo/uc-linux:buggy --pull .
docker tag insideo/uc-linux:buggy insideo/uc-linux:latest

echo "insideo/uc-linux:buddy complete."
