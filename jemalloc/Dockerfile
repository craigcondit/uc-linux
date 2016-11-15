FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/jemalloc-4.3.1.tar.bz2 \
		https://github.com/jemalloc/jemalloc/releases/download/4.3.1/jemalloc-4.3.1.tar.bz2 && \
	cd build && \
	tar xf /download/jemalloc-4.3.1.tar.bz2 && \
	cd jemalloc-4.3.1 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/jemalloc-base-root && \
	make DESTDIR=/build/jemalloc-base-root install && \
	post-root /build/jemalloc-base-root && \
	cd /build/jemalloc-base-root && \
	rm -rf usr/share && \
	(strip --strip-unneeded usr/bin/* || true) && \
	(strip --strip-debug usr/lib/* || true) && \
	rm -f usr/lib/*.a && \

	cp -a /build/jemalloc-base-root /build/libjemalloc-root && \
	cd /build/libjemalloc-root && \
	rm -rf usr/bin usr/lib/pkgconfig usr/include && \
	make-deb \
		/build/libjemalloc-deb \
		/build/libjemalloc-root \
		/control/libjemalloc \
		/packages/libjemalloc_4.3.1-1_amd64.deb && \

	cp -a /build/jemalloc-base-root /build/libjemalloc-devel-root && \
	cd /build/libjemalloc-devel-root && \
	rm usr/lib/*.so* && \
	make-deb \
		/build/libjemalloc-devel-deb \
		/build/libjemalloc-devel-root \
		/control/libjemalloc-devel \
		/packages/libjemalloc-devel_4.3.1-1_amd64.deb
