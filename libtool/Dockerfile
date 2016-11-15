FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel autoconf automake && \
	wget -O /download/libtool-2.4.6.tar.xz \
		http://ftp.gnu.org/gnu/libtool/libtool-2.4.6.tar.xz && \
	cd build && \
	tar xf /download/libtool-2.4.6.tar.xz && \
	cd libtool-2.4.6 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/libtool-root && \
	make DESTDIR=/build/libtool-root install-strip && \
	post-root /build/libtool-root && \
	cd /build/libtool-root && \
	rm -rf usr/share/man usr/share/info && \
	make-deb \
		/build/libtool-deb \
		/build/libtool-root \
		/control/libtool \
		/packages/libtool_2.4.6-1_amd64.deb

