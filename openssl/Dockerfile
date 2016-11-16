FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file linux-devel libz-devel pkg-config perl && \
	opkg clean && \
	wget -O /download/openssl-1.0.2j.tar.gz \
		https://www.openssl.org/source/openssl-1.0.2j.tar.gz && \
	cd /build && \
	tar xf /download/openssl-1.0.2j.tar.gz && \
	cd openssl-1.0.2j && \
	./config --prefix=/usr --openssldir=/etc/ssl --libdir=lib shared zlib-dynamic && \
	sed -i 's# libcrypto.a##;s# libssl.a##' Makefile && \
	make && \
	pre-root /build/openssl-base-root && \
	make INSTALL_PREFIX=/build/openssl-base-root install && \
	cd /build/openssl-base-root && \
	rm -rf etc/ssl/man && \
	(strip --strip-debug usr/lib/* usr/lib/*/* || true) && \
	(strip --strip-unneeded usr/bin/* || true) && \
	post-root /build/openssl-base-root && \

	cp -a /build/openssl-base-root /build/libssl-root && \
	cd /build/libssl-root && \
	rm -rf etc usr/bin usr/include usr/lib/pkgconfig && \
	make-deb \
		/build/libssl-deb \
		/build/libssl-root \
		/control/libssl \
		/packages/libssl_1.0.2j-1_amd64.deb && \

	cp -a /build/openssl-base-root /build/libssl-devel-root && \
	cd /build/libssl-devel-root && \
	rm -rf etc usr/bin usr/lib/engines && \
	rm -f usr/lib/lib*  && \
	make-deb \
		/build/libssl-devel-deb \
		/build/libssl-devel-root \
		/control/libssl-devel \
		/packages/libssl-devel_1.0.2j-1_amd64.deb && \

	cp -a /build/openssl-base-root /build/openssl-root && \
	cd /build/openssl-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/openssl-deb \
		/build/openssl-root \
		/control/openssl \
		/packages/openssl_1.0.2j-1_amd64.deb

