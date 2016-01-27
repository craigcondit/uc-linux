FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libpcre-devel pkg-config libattr-devel libz-devel perl && \
	wget -O /download/rsync-3.1.2.tar.gz \
		https://download.samba.org/pub/rsync/rsync-3.1.2.tar.gz && \
	cd /build && \
	tar xf /download/rsync-3.1.2.tar.gz && \
	cd rsync-3.1.2 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/rsync-root && \
	make DESTDIR=/build/rsync-root install && \
	post-root /build/rsync-root && \
	cd /build/rsync-root && \
	rm -rf usr/share && \
	(strip --strip-unneeded usr/bin/* || true) && \
	make-deb \
		/build/rsync-deb \
		/build/rsync-root \
		/control/rsync \
		/packages/rsync-3.1.2-0_amd64.deb && \
	cd / && \
	rm -rf /build /control /download

