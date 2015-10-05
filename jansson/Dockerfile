FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/jansson-2.7.tar.gz \
		http://www.digip.org/jansson/releases/jansson-2.7.tar.gz && \
	cd build && \
	tar xf /download/jansson-2.7.tar.gz && \
	cd jansson-2.7 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/jansson-base-root && \
	make DESTDIR=/build/jansson-base-root install-strip && \
	post-root /build/jansson-base-root && \
	cd /build/jansson-base-root && \

	cp -a /build/jansson-base-root /build/libjansson-root && \
	cd /build/libjansson-root && \
	rm -rf usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libjansson-deb \
		/build/libjansson-root \
		/control/libjansson \
		/packages/libjansson_2.7-0_amd64.deb && \

	cp -a /build/jansson-base-root /build/libjansson-devel-root && \
	cd /build/libjansson-devel-root && \
	rm usr/lib/*.so* && \
	make-deb \
		/build/libjansson-devel-deb \
		/build/libjansson-devel-root \
		/control/libjansson-devel \
		/packages/libjansson-devel_2.7-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download && \
	opkg --autoremove remove gcc make file linux-devel && \
	opkg clean
