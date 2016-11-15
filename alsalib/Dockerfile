FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/alsa-lib-1.1.2.tar.bz2 \
		ftp://ftp.alsa-project.org/pub/lib/alsa-lib-1.1.2.tar.bz2 && \
	cd build && \
	tar xf /download/alsa-lib-1.1.2.tar.bz2 && \
	cd alsa-lib-1.1.2 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/alsa-lib-base-root && \
	make DESTDIR=/build/alsa-lib-base-root install-strip && \
	post-root /build/alsa-lib-base-root && \
	cd /build/alsa-lib-base-root && \

	cp -a /build/alsa-lib-base-root /build/alsa-utils-root && \
	cd /build/alsa-utils-root && \
	rm -rf usr/lib usr/include usr/share/aclocal && \
	make-deb \
		/build/alsa-utils-deb \
		/build/alsa-utils-root \
		/control/alsa-utils \
		/packages/alsa-utils_1.1.2-1_amd64.deb && \

	cp -a /build/alsa-lib-base-root /build/libalsa-root && \
	cd /build/libalsa-root && \
	rm -rf usr/bin usr/include usr/share usr/lib/pkgconfig && \
	rm -f usr/lib/*.la usr/lib/alsa-lib/smixer/*.la && \
	make-deb \
		/build/libalsa-deb \
		/build/libalsa-root \
		/control/libalsa \
		/packages/libalsa_1.1.2-1_amd64.deb && \

	cp -a /build/alsa-lib-base-root /build/libalsa-devel-root && \
	cd /build/libalsa-devel-root && \
	rm -rf usr/bin usr/share/alsa && \
	rm -f usr/lib/*.so* usr/lib/alsa-lib/smixer/*.so* && \
	make-deb \
		/build/libalsa-devel-deb \
		/build/libalsa-devel-root \
		/control/libalsa-devel \
		/packages/libalsa-devel_1.1.2-1_amd64.deb

