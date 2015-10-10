FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config openssl libssl-devel libevent-devel libxml2-devel && \
	wget -O /download/spdylay-1.3.2.tar.bz2 \
		https://github.com/tatsuhiro-t/spdylay/releases/download/v1.3.2/spdylay-1.3.2.tar.bz2 && \
	cd build && \
	tar xf /download/spdylay-1.3.2.tar.bz2 && \
	cd spdylay-1.3.2 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/spdylay-base-root && \
	make DESTDIR=/build/spdylay-base-root install-strip && \
	post-root /build/spdylay-base-root && \
	cd /build/spdylay-base-root && \
	rm -rf usr/share && \

	cp -a /build/spdylay-base-root /build/spdylay-root && \
	cd /build/spdylay-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/spdylay-deb \
		/build/spdylay-root \
		/control/spdylay \
		/packages/spdylay_1.3.2-0_amd64.deb && \

	cp -a /build/spdylay-base-root /build/libspdylay-root && \
	cd /build/libspdylay-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libspdylay-deb \
		/build/libspdylay-root \
		/control/libspdylay \
		/packages/libspdylay_1.3.2-0_amd64.deb && \

	cp -a /build/spdylay-base-root /build/libspdylay-devel-root && \
	cd /build/libspdylay-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libspdylay-devel-deb \
		/build/libspdylay-devel-root \
		/control/libspdylay-devel \
		/packages/libspdylay-devel_1.3.2-0_amd64.deb

