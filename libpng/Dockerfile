FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/libpng-1.6.18.tar.xz \
		http://downloads.sourceforge.net/libpng/libpng-1.6.18.tar.xz && \
	wget -O /download/libpng-1.6.18-apng.patch.gz \
		http://downloads.sourceforge.net/libpng-apng/libpng-1.6.18-apng.patch.gz && \
	cd /build && \
	tar xf /download/libpng-1.6.18.tar.xz && \
	cd libpng-1.6.18 && \
	gzip -cd /download/libpng-1.6.18-apng.patch.gz | patch -p1 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libpng-base-root && \
	make DESTDIR=/build/libpng-base-root install-strip && \
	post-root /build/libpng-base-root && \
	cd /build/libpng-base-root && \
	rm -rf usr/share && \

	cp -a /build/libpng-base-root /build/png-utils-root && \
	cd /build/png-utils-root && \
	rm -rf usr/include usr/lib && \
	rm -f usr/bin/*-config && \
	make-deb \
		/build/png-utils-deb \
		/build/png-utils-root \
		/control/png-utils \
		/packages/png-utils_1.6.18-0_amd64.deb && \

	cp -a /build/libpng-base-root /build/libpng-root && \
	cd /build/libpng-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libpng-deb \
		/build/libpng-root \
		/control/libpng \
		/packages/libpng_1.6.18-0_amd64.deb && \

	cp -a /build/libpng-base-root /build/libpng-devel-root && \
	cd /build/libpng-devel-root && \
	rm -f usr/bin/pngfix usr/bin/png-fix-itxt && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libpng-devel-deb \
		/build/libpng-devel-root \
		/control/libpng-devel \
		/packages/libpng-devel_1.6.18-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
