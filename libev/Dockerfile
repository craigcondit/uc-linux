FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/libev-4.20.tar.gz \
		http://dist.schmorp.de/libev/Attic/libev-4.20.tar.gz && \
	cd /build && \
	tar xf /download/libev-4.20.tar.gz && \
	cd libev-4.20 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libev-base-root && \
	make DESTDIR=/build/libev-base-root install-strip && \
	post-root /build/libev-base-root && \
	cd /build/libev-base-root && \
	rm -rf usr/share && \
	rm -f usr/include/event.h && \

	cp -a /build/libev-base-root /build/libev-root && \
	cd /build/libev-root && \
	rm -rf usr/include && \
	rm usr/lib/*.la && \
	make-deb \
		/build/libev-deb \
		/build/libev-root \
		/control/libev \
		/packages/libev_4.20-0_amd64.deb && \

	cp -a /build/libev-base-root /build/libev-devel-root && \
	cd /build/libev-devel-root && \
	rm -rf usr/lib/*.so* && \
	make-deb \
		/build/libev-devel-deb \
		/build/libev-devel-root \
		/control/libev-devel \
		/packages/libev-devel_4.20-0_amd64.deb
