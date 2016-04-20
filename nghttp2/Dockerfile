FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config openssl libssl-devel \
		libevent-devel libxml2-devel libev-devel libspdylay-devel \
		libjansson-devel libjemalloc-devel bison ruby && \
	wget -O /download/nghttp2-1.9.2.tar.bz2 \
		https://github.com/tatsuhiro-t/nghttp2/releases/download/v1.9.2/nghttp2-1.9.2.tar.bz2 && \
	cd /build && \
	tar xf /download/nghttp2-1.9.2.tar.bz2 && \
	cd nghttp2-1.9.2 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static --with-mruby && \
	MAKE="make -j4" make && \
	pre-root /build/nghttp2-base-root && \
	make DESTDIR=/build/nghttp2-base-root install-strip && \
	post-root /build/nghttp2-base-root && \
	cd /build/nghttp2-base-root && \
	rm -rf usr/share/man usr/share/doc && \

	cp -a /build/nghttp2-base-root /build/nghttp2-root && \
	cd /build/nghttp2-root && \
	rm -rf usr/lib usr/include && \
	make-deb \
		/build/nghttp2-deb \
		/build/nghttp2-root \
		/control/nghttp2 \
		/packages/nghttp2_1.9.2-0_amd64.deb && \

	cp -a /build/nghttp2-base-root /build/libnghttp2-root && \
	cd /build/libnghttp2-root && \
	rm -rf usr/bin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libnghttp2-deb \
		/build/libnghttp2-root \
		/control/libnghttp2 \
		/packages/libnghttp2_1.9.2-0_amd64.deb && \

	cp -a /build/nghttp2-base-root /build/libnghttp2-devel-root && \
	cd /build/libnghttp2-devel-root && \
	rm -rf usr/bin usr/share && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libnghttp2-devel-deb \
		/build/libnghttp2-devel-root \
		/control/libnghttp2-devel \
		/packages/libnghttp2-devel_1.9.2-0_amd64.deb
