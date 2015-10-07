FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	set +x && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config x11-util-macros x11-proto-devel && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	wget -O /download/libXau-1.0.8.tar.bz2 \
		http://ftp.x.org/pub/individual/lib/libXau-1.0.8.tar.bz2 && \
	cd /build && \
	tar xf /download/libXau-1.0.8.tar.bz2 && \
	cd libXau-1.0.8 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xau-base-root && \
	make DESTDIR=/build/libx11-xau-base-root install-strip && \
	post-root /build/libx11-xau-base-root && \
	cd /build/libx11-xau-base-root && \
	rm -rf usr/share && \

	cp -a /build/libx11-xau-base-root /build/libx11-xau-root && \
	cd /build/libx11-xau-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xau-deb \
		/build/libx11-xau-root \
		/control/libx11-xau \
		/packages/libx11-xau_1.0.8-0_amd64.deb && \

	cp -a /build/libx11-xau-base-root /build/libx11-xau-devel-root && \
	cd /build/libx11-xau-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xau-devel-deb \
		/build/libx11-xau-devel-root \
		/control/libx11-xau-devel \
		/packages/libx11-xau-devel_1.0.8-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
