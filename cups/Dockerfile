FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libz-devel && \
	wget -O /download/cups-2.1.0-source.tar.bz2 \
		https://www.cups.org/software/2.1.0/cups-2.1.0-source.tar.bz2 && \
	cd build && \
	tar xf /download/cups-2.1.0-source.tar.bz2 && \
	cd cups-2.1.0 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/cups-base-root && \
	make BUILDROOT=/build/cups-base-root install && \
	post-root /build/cups-base-root && \
	cd /build/cups-base-root && \
	rm -rf etc usr/var usr/share/doc usr/share/locale usr/share/man && \
	(strip --strip-unneeded usr/bin/* usr/sbin/* || true) && \
	(strip --strip-debug usr/lib/* || true) && \

	cp -a /build/cups-base-root /build/cups-root && \
	cd /build/cups-root && \
	rm -rf usr/include && \
	rm -f usr/lib/lib* && \
	make-deb \
		/build/cups-deb \
		/build/cups-root \
		/control/cups \
		/packages/cups_2.1.0-0_amd64.deb && \

	cp -a /build/cups-base-root /build/libcups-root && \
	cd /build/libcups-root && \
	rm -rf usr/bin usr/sbin usr/lib/cups usr/share usr/include && \
	make-deb \
		/build/libcups-deb \
		/build/libcups-root \
		/control/libcups \
		/packages/libcups_2.1.0-0_amd64.deb && \

	cp -a /build/cups-base-root /build/libcups-devel-root && \
	cd /build/libcups-devel-root && \
	rm -rf usr/bin usr/sbin usr/share usr/lib && \
	make-deb \
		/build/libcups-devel-deb \
		/build/libcups-devel-root \
		/control/libcups-devel \
		/packages/libcups-devel_2.1.0-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
