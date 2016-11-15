#!/bin/bash
set -e

cd "$(dirname $0)"
cd "$(pwd -P)"

docker pull insideo/uc-linux-bootstrap:hydrogen
docker rm -f uc-linux-hydrogen-build 2>/dev/null || :
docker run --rm=false --name=uc-linux-hydrogen-build insideo/uc-linux-bootstrap:hydrogen /bin/true
docker export uc-linux-hydrogen-build | xz > uc-linux-hydrogen/rootfs.tar.xz
docker rm -f uc-linux-hydrogen-build 2>/dev/null || :

echo "Root image built."
