#!/bin/bash
set -ex

cd "$(dirname $0)"
cd "$(pwd -P)"

docker pull insideo/uc-linux-bootstrap:buggy
docker rm uc-linux-bootstrap-tmp 2>/dev/null || true
docker create --name uc-linux-bootstrap-tmp insideo/uc-linux-bootstrap:buggy
docker export uc-linux-bootstrap-tmp | xz -9 > uc-linux-buggy/rootfs.tar.xz
docker rm uc-linux-bootstrap-tmp 2>/dev/null || true
