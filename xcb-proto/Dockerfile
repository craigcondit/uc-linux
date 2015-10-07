FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	set +x && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config x11-util-macros x11-proto-devel python27 && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	wget -O /download/xcb-proto-1.11.tar.bz2 \
		http://xcb.freedesktop.org/dist/xcb-proto-1.11.tar.bz2
	cd /build && \
	tar xf /download/xcb-proto-1.11.tar.bz2 && \
	cd xcb-proto-1.11 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/xcb-proto-root && \
	make DESTDIR=/build/xcb-proto-root install-strip && \
	post-root /build/xcb-proto-root && \
	cd /build/xcb-proto-root && \
	make-deb \
		/build/xcb-proto-deb \
		/build/xcb-proto-root \
		/control/xcb-proto \
		/packages/xcb-proto_1.11-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
