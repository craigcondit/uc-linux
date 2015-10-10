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

IMG=$(echo "${PACKAGE}" | tr 'A-Z' 'a-z')

BUILD_ARGS=
if [ "${QUICK}" != "yes" ]; then
  ARGS="${ARGS} --pull"
fi

docker build -t "insideo/uc-linux-${IMG}-build" ${ARGS} .

docker rm -f "uc-linux-${IMG}-tmp" 2>/dev/null || true
docker run --name "uc-linux-${IMG}-tmp" "insideo/uc-linux-${IMG}-build" /bin/sh
docker cp "uc-linux-${IMG}-tmp:/packages" ..
docker rm -f "uc-linux-${IMG}-tmp"

if [ "${QUICK}" != "yes" ]; then
  docker rmi "insideo/uc-linux-${IMG}-build"
else 
  echo "Quick build of package ${PACKAGE} complete."
  exit 0
fi

echo "Build of package ${PACKAGE} complete."
