FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	wget -O /download/util-macros-1.19.0.tar.bz2 \
		http://ftp.x.org/pub/individual/util/util-macros-1.19.0.tar.bz2 && \
	cd /build && \
	tar xf /download/util-macros-1.19.0.tar.bz2 && \
	cd util-macros-1.19.0 && \
	./configure $XORG_CONFIG && \
	pre-root /build/x11-util-macros-root && \
	make DESTDIR=/build/x11-util-macros-root install && \
	post-root /build/x11-util-macros-root && \
	cd /build/x11-util-macros-root && \
	rm -rf usr/share/util-macros && \
	make-deb \
		/build/x11-util-macros-deb \
		/build/x11-util-macros-root \
		/control/x11-util-macros \
		/packages/x11-util-macros_1.19.0-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download /Manifest
