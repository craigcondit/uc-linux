FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel m4 bison && \
	wget -O /download/flex-2.6.0.tar.xz \
		http://prdownloads.sourceforge.net/flex/flex-2.6.0.tar.xz && \
	cd build && \
	tar xf /download/flex-2.6.0.tar.xz && \
	cd flex-2.6.0 && \
	sed -i -e '/test-bison/d' tests/Makefile.in && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--docdir=/usr/share/doc/flex-2.6.0 && \
	MAKE="make -j4" make && \
	pre-root /build/flex-root && \
	make DESTDIR=/build/flex-root install-strip && \
	post-root /build/flex-root && \
	cd /build/flex-root && \
	rm -rf usr/share && \
	make-deb \
		/build/flex-deb \
		/build/flex-root \
		/control/flex \
		/packages/flex_2.6.0-1_amd64.deb
