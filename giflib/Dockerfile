FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/giflib-5.1.1.tar.bz2 \
		http://downloads.sourceforge.net/giflib/giflib-5.1.1.tar.bz2 && \
	cd /build && \
	tar xf /download/giflib-5.1.1.tar.bz2 && \
	cd giflib-5.1.1 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/giflib-base-root && \
	make DESTDIR=/build/giflib-base-root install-strip && \
	post-root /build/giflib-base-root && \
	cd /build/giflib-base-root && \

	cp -a /build/giflib-base-root /build/gif-utils-root && \
	cd /build/gif-utils-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/gif-utils-deb \
		/build/gif-utils-root \
		/control/gif-utils \
		/packages/gif-utils_5.1.1-0_amd64.deb && \

	cp -a /build/giflib-base-root /build/libgif-root && \
	cd /build/libgif-root && \
	rm -rf usr/include usr/bin && \
	rm usr/lib/*.la && \
	make-deb \
		/build/libgif-deb \
		/build/libgif-root \
		/control/libgif \
		/packages/libgif_5.1.1-0_amd64.deb && \

	cp -a /build/giflib-base-root /build/libgif-devel-root && \
	cd /build/libgif-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libgif-devel-deb \
		/build/libgif-devel-root \
		/control/libgif-devel \
		/packages/libgif-devel_5.1.1-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
