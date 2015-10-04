#!/bin/bash
set -e

usage() {
  echo "Usage: $0 <package-dir>" >&2
  exit 1
}

QUICK=no
if [ "$1" == "-q" ]; then
  shift
  QUICK=yes
fi

PACKAGE=$1
[ ! -z "${PACKAGE}" ] || usage

set -e
cd "$(dirname $0)"
cd "$(pwd -P)/${PACKAGE}"

docker build -t "insideo/uc-linux-${PACKAGE}-build" --pull .

if [ "${QUICK}" != "yes" ]; then
  docker rm -f "uc-linux-${PACKAGE}-tmp" 2>/dev/null || true
  docker run --name "uc-linux-${PACKAGE}-tmp" "insideo/uc-linux-${PACKAGE}-build" /bin/sh
  docker cp "uc-linux-${PACKAGE}-tmp:/packages" ..
  docker rm -f "uc-linux-${PACKAGE}-tmp"
  docker rmi "insideo/uc-linux-${PACKAGE}-build"
else 
  echo "Quick build of package ${PACKAGE} complete."
  exit 0
fi

echo "Build of package ${PACKAGE} complete."
