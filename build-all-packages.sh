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
	flex \
	bison \
	zip \
	unzip \
	giflib \
	ncurses \
	readline \
	bash \
	alsalib \
	cups \
	libpng \
	gettext \
	python27 \
	freetype \
	fontconfig \
	x11-util-macros \
	x11-proto-devel \
	libx11-xau \
	xcb-proto \
	libx11-xcb \
	xorg-libs \
	openjdk8 \
	ruby \
	spdylay \
	jemalloc \
	nghttp2 \
	oracle-server-jre-8 \
; do ./build-package.sh ${package} ; done

