#!/bin/bash
set -e

usage() {
  echo "Usage: $0 <package-dir>" >&2
  exit 1
}

PACKAGE=$1
[ ! -z "${PACKAGE}" ] || usage

set -e
cd "$(dirname $0)"
cd "$(pwd -P)/${PACKAGE}"

docker build -t "insideo/uc-linux-${PACKAGE}-build" --pull .
docker rm -f "uc-linux-${PACKAGE}-tmp" 2>/dev/null || true
docker run --name "uc-linux-${PACKAGE}-tmp" "insideo/uc-linux-${PACKAGE}-build" /bin/sh
docker cp "uc-linux-${PACKAGE}-tmp:/packages" ..
docker rm -f "uc-linux-${PACKAGE}-tmp"

echo "Build of package ${PACKAGE} complete."
