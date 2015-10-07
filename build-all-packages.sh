#!/bin/sh

set -e
cd "$(dirname $0)"
cd "$(pwd -P)"

for package in \
	libffi \
	libevent \
	libev \
	autoconf \
	automake \
	libtool \
	bison \
	zip \
	unzip \
	giflib \
	alsalib \
	cups \
	libpng \
	freetype \
	fontconfig \
	ruby \
	python27 \
	spdylay \
	jemalloc \
	nghttp2 \
	oracle-server-jre-8 \
; do ./build-package.sh ${package} ; done

