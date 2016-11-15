FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libz-devel && \
	wget -O /download/cups-2.2.1-source.tar.gz \
		https://github.com/apple/cups/releases/download/v2.2.1/cups-2.2.1-source.tar.gz && \
	cd build && \
	tar xf /download/cups-2.2.1-source.tar.gz && \
	cd cups-2.2.1 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--sysconfdir=/etc --localstatedir=/var --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/cups-base-root && \
	make BUILDROOT=/build/cups-base-root install && \
	post-root /build/cups-base-root && \
	cd /build/cups-base-root && \
	rm -rf etc/rc.d usr/var usr/share/doc usr/share/locale usr/share/man && \
	(strip --strip-unneeded usr/bin/* usr/sbin/* || true) && \
	(strip --strip-debug usr/lib/* || true) && \

	cp -a /build/cups-base-root /build/cups-root && \
	cd /build/cups-root && \
	rm -rf usr/include && \
	rm -f usr/lib/lib* && \
	mv usr/bin/lp usr/bin/lp.cups && \
	mv usr/bin/lpq usr/bin/lpq.cups && \
	mv usr/bin/lpr usr/bin/lpr.cups && \
	mv usr/bin/lprm usr/bin/lprm.cups && \	
	make-deb \
		/build/cups-deb \
		/build/cups-root \
		/control/cups \
		/packages/cups_2.2.1-1_amd64.deb && \

	cp -a /build/cups-base-root /build/libcups-root && \
	cd /build/libcups-root && \
	rm -rf etc usr/bin usr/sbin usr/lib/cups usr/share usr/include && \
	make-deb \
		/build/libcups-deb \
		/build/libcups-root \
		/control/libcups \
		/packages/libcups_2.2.1-1_amd64.deb && \

	cp -a /build/cups-base-root /build/libcups-devel-root && \
	cd /build/libcups-devel-root && \
	rm -rf etc usr/bin usr/sbin usr/share usr/lib && \
	make-deb \
		/build/libcups-devel-deb \
		/build/libcups-devel-root \
		/control/libcups-devel \
		/packages/libcups-devel_2.2.1-1_amd64.deb
