FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel liblzma-devel libbz2-devel libz-devel libssl-devel && \
	wget -O /download/libarchive-3.2.2.tar.gz \
		http://www.libarchive.org/downloads/libarchive-3.2.2.tar.gz && \
	cd /build && \
	tar xf /download/libarchive-3.2.2.tar.gz && \
	cd libarchive-3.2.2 && \
	./configure --prefix=/usr --disable-bsdtar --disable-bsdcpio && \
	MAKE="make -j4" make && \
	pre-root /build/libarchive-base-root && \
	make DESTDIR=/build/libarchive-base-root install-strip && \
	post-root /build/libarchive-base-root && \
	cd /build/libarchive-base-root && \
	rm -rf usr/share && \

	cp -a /build/libarchive-base-root /build/libarchive-root && \
	cd /build/libarchive-root && \
	rm -rf usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.a usr/lib/*.la && \
	make-deb \
		/build/libarchive-deb \
		/build/libarchive-root \
		/control/libarchive \
		/packages/libarchive_3.2.2-2_amd64.deb && \

	cp -a /build/libarchive-base-root /build/libarchive-devel-root && \
	cd /build/libarchive-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libarchive-devel-deb \
		/build/libarchive-devel-root \
		/control/libarchive-devel \
		/packages/libarchive-devel_3.2.2-2_amd64.deb

