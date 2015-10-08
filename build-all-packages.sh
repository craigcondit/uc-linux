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
	python27 \
	freetype \
	fontconfig \
	x11-util-macros \
	x11-proto-devel \
	libx11-xau \
	xcb-proto \
	libx11-xcb \
	ruby \
	spdylay \
	jemalloc \
	nghttp2 \
	oracle-server-jre-8 \
; do ./build-package.sh ${package} ; done

