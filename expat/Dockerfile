FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/expat-2.2.0.tar.bz2 \
		http://prdownloads.sourceforge.net/expat/expat-2.2.0.tar.bz2 && \
	cd /build && \
	tar xf /download/expat-2.2.0.tar.bz2 && \
	cd expat-2.2.0 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/expat-base-root && \
	make DESTDIR=/build/expat-base-root install && \
	post-root /build/expat-base-root && \
	cd /build/expat-base-root && \
	rm -rf usr/share && \
	(strip --strip-debug usr/lib/* || true) && \
	(strip --strip-unneeded usr/bin/* || true) && \

	cp -a /build/expat-base-root /build/expat-root && \
	cd /build/expat-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/expat-deb \
		/build/expat-root \
		/control/expat \
		/packages/expat_2.2.0-1_amd64.deb && \

	cp -a /build/expat-base-root /build/libexpat-root && \
	cd /build/libexpat-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libexpat-deb \
		/build/libexpat-root \
		/control/libexpat \
		/packages/libexpat_2.2.0-1_amd64.deb && \

	cp -a /build/expat-base-root /build/libexpat-devel-root && \
	cd /build/libexpat-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libexpat-devel-deb \
		/build/libexpat-devel-root \
		/control/libexpat-devel \
		/packages/libexpat-devel_2.2.0-1_amd64.deb

