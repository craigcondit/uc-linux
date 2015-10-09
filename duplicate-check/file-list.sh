#!/bin/sh

usage() {
  print "Usage: $0 <deb>" >&2
  exit 1
}

PKG=$1
if [ -z "${PKG}" ]; then
  usage
fi

echo "Processing ${PKG}..." >&2
PKGNAME=$(dpkg-deb -f "${PKG}" Package)

dpkg-deb -c "${PKG}" | grep -v ^d | awk '{print $6}' | sed 's@^\.[/]*@/@' | sort | sed "s/^/${PKGNAME}:/"

