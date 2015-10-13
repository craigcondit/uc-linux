FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config && \
	wget -O /download/pcre-8.37.tar.bz2 \
		ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.37.tar.bz2 && \
	cd build && \
	tar xf /download/pcre-8.37.tar.bz2 && \
	cd pcre-8.37 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) --disable-static -with-shared \
		--enable-utf --enable-unicode-properties --enable-jit && \
	MAKE="make -j4" make && \
	pre-root /build/pcre-orig-root && \
	make DESTDIR=/build/pcre-orig-root install-strip && \
	post-root /build/pcre-orig-root && \
	cd /build/pcre-orig-root && \
	rm -rf usr/share && \

	cp -a /build/pcre-orig-root /build/pcre-utils-root && \
	cd /build/pcre-utils-root && \
	rm -rf usr/lib usr/share usr/include && \
	rm -f usr/bin/pcre-config && \
	make-deb \
		/build/pcre-utils-deb \
		/build/pcre-utils-root \
		/control/pcre-utils \
		/packages/pcre-utils_8.37-0_amd64.deb && \

	cp -a /build/pcre-orig-root /build/libpcre-root && \
	cd /build/libpcre-root && \
	rm -rf usr/bin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libpcre-deb \
		/build/libpcre-root \
		/control/libpcre \
		/packages/libpcre_8.37-0_amd64.deb && \

	cp -a /build/pcre-orig-root /build/libpcre-devel-root && \
	cd /build/libpcre-devel-root && \
	rm -rf usr/bin/pcretest usr/bin/pcregrep  && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libpcre-devel-deb \
		/build/libpcre-devel-root \
		/control/libpcre-devel \
		/packages/libpcre-devel_8.37-0_amd64.deb

