FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel perl libattr-devel && \
	wget -O /download/libcap-2.25.tar.xz \
		https://www.kernel.org/pub/linux/libs/security/linux-privs/libcap2/libcap-2.25.tar.xz && \
	cd /build && \
	tar xf /download/libcap-2.25.tar.xz && \
	cd libcap-2.25 && \
	sed -i '/install.*STALIBNAME/d' libcap/Makefile && \
	MAKE="make -j4" make && \
	pre-root /build/libcap-base-root && \
	make RAISE_SETFCAP=no prefix=/build/libcap-base-root/usr install && \
	post-root /build/libcap-base-root && \
	cd /build/libcap-base-root && \
	rm -rf usr/share && \
	(strip --strip-unneeded usr/sbin/* || true) && \
	(strip --strip-debug usr/lib/* || true) && \

	cp -a /build/libcap-base-root /build/cap-utils-root && \
	cd /build/cap-utils-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/cap-utils-deb \
		/build/cap-utils-root \
		/control/cap-utils \
		/packages/cap-utils_2.25-1_amd64.deb && \

	cp -a /build/libcap-base-root /build/libcap-root && \
	cd /build/libcap-root && \
	rm -rf usr/sbin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libcap-deb \
		/build/libcap-root \
		/control/libcap \
		/packages/libcap_2.25-1_amd64.deb && \

	cp -a /build/libcap-base-root /build/libcap-devel-root && \
	cd /build/libcap-devel-root && \
	rm -rf usr/sbin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libcap-devel-deb \
		/build/libcap-devel-root \
		/control/libcap-devel \
		/packages/libcap-devel_2.25-1_amd64.deb

