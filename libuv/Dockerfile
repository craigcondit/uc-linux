FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file libtool autoconf automake && \
	wget -O /download/libuv-1.10.1.tar.gz \
		http://dist.libuv.org/dist/v1.10.1/libuv-v1.10.1.tar.gz && \
	cd /build && \
	tar xf /download/libuv-1.10.1.tar.gz && \
	cd libuv-v1.10.1 && \
	sh autogen.sh && \
	./configure --prefix=/usr && \
	MAKE="make -j4" make && \
	pre-root /build/libuv-base-root && \
	make DESTDIR=/build/libuv-base-root install-strip && \
	post-root /build/libuv-base-root && \
	cd /build/libuv-base-root && \

	cp -a /build/libuv-base-root /build/libuv-root && \
	cd /build/libuv-root && \
	rm -rf usr/include && \
	rm -f usr/lib/*.a usr/lib/*.la && \
	make-deb \
		/build/libuv-deb \
		/build/libuv-root \
		/control/libuv \
		/packages/libuv_1.10.1-1_amd64.deb && \

	cp -a /build/libuv-base-root /build/libuv-devel-root && \
	cd /build/libuv-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libuv-devel-deb \
		/build/libuv-devel-root \
		/control/libuv-devel \
		/packages/libuv-devel_1.10.1-1_amd64.deb

