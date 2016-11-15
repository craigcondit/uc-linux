FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libbz2-devel libpng-devel && \
	wget -O /download/freetype-2.7.tar.bz2 \
		http://downloads.sourceforge.net/freetype/freetype-2.7.tar.bz2 && \
	cd /build && \
	tar xf /download/freetype-2.7.tar.bz2 && \
	cd freetype-2.7 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/freetype-base-root && \
	make DESTDIR=/build/freetype-base-root install && \
	post-root /build/freetype-base-root && \
	cd /build/freetype-base-root && \
	rm -rf usr/share/man && \
	(strip --strip-debug usr/lib/* || true) && \
	
	cp -a /build/freetype-base-root /build/libfreetype-root && \
	cd /build/libfreetype-root && \
	rm -rf usr/include usr/bin usr/lib/pkgconfig usr/share && \
	rm usr/lib/*.la && \
	make-deb \
		/build/libfreetype-deb \
		/build/libfreetype-root \
		/control/libfreetype \
		/packages/libfreetype_2.7.0-1_amd64.deb && \

	cp -a /build/freetype-base-root /build/libfreetype-devel-root && \
	cd /build/libfreetype-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libfreetype-devel-deb \
		/build/libfreetype-devel-root \
		/control/libfreetype-devel \
		/packages/libfreetype-devel_2.7.0-1_amd64.deb
