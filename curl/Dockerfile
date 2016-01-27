FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file linux-devel pkg-config openssl libssl-devel \
		libevent-devel libxml2-devel libev-devel libspdylay-devel \
		libjansson-devel libjemalloc-devel bison ruby libnghttp2-devel && \
	opkg clean && \
	wget -O /download/curl-7.47.0.tar.bz2 \
		https://github.com/bagder/curl/releases/download/curl-7_47_0/curl-7.47.0.tar.bz2 && \
	cd /build && \
	tar xf /download/curl-7.47.0.tar.bz2 && \
	cd curl-7.47.0 && \
	./configure --prefix=/usr --disable-static --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/curl-base-root && \
	make DESTDIR=/build/curl-base-root install-strip && \
	post-root /build/curl-base-root && \
	cd /build/curl-base-root && \
	rm -rf usr/share/man && \

	cp -a /build/curl-base-root /build/curl-root && \
	cd /build/curl-root && \
	rm -rf usr/lib usr/include usr/share usr/bin/curl-config && \
	make-deb \
		/build/curl-deb \
		/build/curl-root \
		/control/curl \
		/packages/curl_7.47.0-0_amd64.deb && \

	cp -a /build/curl-base-root /build/libcurl-root && \
	cd /build/libcurl-root && \
	rm -rf usr/bin usr/share usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libcurl-deb \
		/build/libcurl-root \
		/control/libcurl \
		/packages/libcurl_7.47.0-0_amd64.deb && \

	cp -a /build/curl-base-root /build/libcurl-devel-root && \
	cd /build/libcurl-devel-root && \
	rm -rf usr/bin/curl && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libcurl-devel-deb \
		/build/libcurl-devel-root \
		/control/libcurl-devel \
		/packages/libcurl-devel_7.47.0-0_amd64.deb

