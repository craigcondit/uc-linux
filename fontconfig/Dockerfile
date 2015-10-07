FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libfreetype-devel pkg-config libxml2-devel && \
	wget -O /download/fontconfig-2.11.1.tar.bz2 \
		http://www.freedesktop.org/software/fontconfig/release/fontconfig-2.11.1.tar.bz2 && \
	cd /build && \
	tar xf /download/fontconfig-2.11.1.tar.bz2 && \
	cd fontconfig-2.11.1 && \
	./configure \
		--prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--disable-docs --docdir=/usr/share/doc/fontconfig-=2.11.1 \
		--host=$(gcc -dumpmachine) --target=$(gcc -dumpmachine) \
		--build=$(gcc -dumpmachine) --disable-static \
		--enable-libxml2 && \
	MAKE="make -j4" make && \
	pre-root /build/fontconfig-base-root && \
	make DESTDIR=/build/fontconfig-base-root install-strip && \
	post-root /build/fontconfig-base-root && \
	cd /build/fontconfig-base-root && \
	
	cp -a /build/fontconfig-base-root /build/fontconfig-utils-root && \
	cd /build/fontconfig-utils-root && \
	rm -rf usr/lib usr/include && \
	make-deb \
		/build/fontconfig-utils-deb \
		/build/fontconfig-utils-root \
		/control/fontconfig-utils \
		/packages/fontconfig-utils_2.11.1-0_amd64.deb && \

	cp -a /build/fontconfig-base-root /build/libfontconfig-root && \
	cd /build/libfontconfig-root && \
	rm -rf etc var usr/lib/pkgconfig usr/include usr/share usr/bin && \
	rm usr/lib/*.la && \
	make-deb \
		/build/libfontconfig-deb \
		/build/libfontconfig-root \
		/control/libfontconfig \
		/packages/libfontconfig_2.11.1-0_amd64.deb && \

	cp -a /build/fontconfig-base-root /build/libfontconfig-devel-root && \
	cd /build/libfontconfig-devel-root && \
	rm -rf etc var usr/share usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libfontconfig-devel-deb \
		/build/libfontconfig-devel-root \
		/control/libfontconfig-devel \
		/packages/libfontconfig-devel_2.11.1-0_amd64.deb && \

	cd / && \
	rm -rf /build /control /download
