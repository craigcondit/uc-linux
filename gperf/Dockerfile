FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/gperf-3.0.4.tar.gz \
		http://ftp.gnu.org/gnu/gperf/gperf-3.0.4.tar.gz && \
	cd build && \
	tar xf /download/gperf-3.0.4.tar.gz && \
	cd gperf-3.0.4 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--docdir=/usr/share/doc/gperf-3.0.4 && \
	MAKE="make -j4" make && \
	pre-root /build/gperf-root && \
	make DESTDIR=/build/gperf-root install && \
	post-root /build/gperf-root && \
	cd /build/gperf-root && \
	rm -rf usr/share && \
	(strip --strip-unneeded usr/bin/* || true) && \
	make-deb \
		/build/gperf-deb \
		/build/gperf-root \
		/control/gperf \
		/packages/gperf_3.0.4-0_amd64.deb
