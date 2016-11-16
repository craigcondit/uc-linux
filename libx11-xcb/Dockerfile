FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	set +x && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config x11-util-macros x11-proto-devel libx11-xau-devel xcb-proto && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	wget -O /download/libxcb-1.12.tar.bz2 \
		http://xcb.freedesktop.org/dist/libxcb-1.12.tar.bz2 && \
	cd /build && \
	tar xf /download/libxcb-1.12.tar.bz2 && \
	cd libxcb-1.12 && \
	sed -i "s/pthread-stubs//" configure && \
	./configure $XORG_CONFIG \
		--enable-xinput \
		--without-doxygen \
		--docdir='${datadir}'/doc/libxcb-1.12 && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xcb-base-root && \
	make DESTDIR=/build/libx11-xcb-base-root install-strip && \
	post-root /build/libx11-xcb-base-root && \
	cd /build/libx11-xcb-base-root && \
	rm -rf usr/share && \

	cp -a /build/libx11-xcb-base-root /build/libx11-xcb-root && \
	cd /build/libx11-xcb-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xcu-deb \
		/build/libx11-xcb-root \
		/control/libx11-xcb \
		/packages/libx11-xcb_1.12.0-1_amd64.deb && \

	cp -a /build/libx11-xcb-base-root /build/libx11-xcb-devel-root && \
	cd /build/libx11-xcb-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xcb-devel-deb \
		/build/libx11-xcb-devel-root \
		/control/libx11-xcb-devel \
		/packages/libx11-xcb-devel_1.12.0-1_amd64.deb

