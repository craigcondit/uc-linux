FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/libffi-3.2.1.tar.gz \
		ftp://sourceware.org/pub/libffi/libffi-3.2.1.tar.gz && \
	cd build && \
	tar xf /download/libffi-3.2.1.tar.gz && \
	cd libffi-3.2.1 && \
	sed -e '/^includesdir/ s/$(libdir).*$/$(includedir)/' \
		-i include/Makefile.in && \
	sed -e '/^includedir/ s/=.*$/=@includedir@/' \
		-e 's/^Cflags: -I${includedir}/Cflags:/' \
		-i libffi.pc.in && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libffi-base-root && \
	make DESTDIR=/build/libffi-base-root install-strip && \
	post-root /build/libffi-base-root && \
	cd /build/libffi-base-root && \
	rm -rf usr/share && \

	cp -a /build/libffi-base-root /build/libffi-root && \
	cd /build/libffi-root && \
	rm -rf usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libffi-deb \
		/build/libffi-root \
		/control/libffi \
		/packages/libffi_3.2.1-0_amd64.deb && \

	cp -a /build/libffi-base-root /build/libffi-devel-root && \
	cd /build/libffi-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libffi-devel-deb \
		/build/libffi-devel-root \
		/control/libffi-devel \
		/packages/libffi-devel_3.2.1-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download && \
	opkg --autoremove remove gcc make file linux-devel && \
	opkg clean
