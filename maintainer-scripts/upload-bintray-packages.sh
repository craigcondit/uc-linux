#!/bin/bash

BINTRAY_USER=insideo
BINTRAY_ORG=insideo
BINTRAY_API_KEY_FILE=~/.bintray/apikey

usage() {
  echo "Usage: $0 [--force] <package-directory>" >&2
  exit 1
}

cd "$(dirname $0)"
cd "$(pwd -P)"
cd ..

ARGS=
if [ "$1" == "--force" ]; then
  shift
  ARGS="${ARGS} -f"
fi

PKG_DIR=$1
if [ -z "${PKG_DIR}" ]; then
  usage
fi

echo "Uploading main packages for ${PKG_DIR}..."
find ${PKG_DIR} -type f -name "*.deb" \
	-exec ./upload-package.py -u "${BINTRAY_USER}" -o "${BINTRAY_ORG}" ${ARGS} \
	-a "${BINTRAY_API_KEY_FILE}" -r uc-linux-main-hydrogen -c main -d hydrogen "{}" \;
