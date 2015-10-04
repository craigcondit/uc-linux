FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel m4 perl && \
	wget -O /download/autoconf-2.69.tar.xz \
		http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.xz && \
	cd build && \
	tar xf /download/autoconf-2.69.tar.xz && \
	cd autoconf-2.69 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/autoconf-root && \
	make DESTDIR=/build/autoconf-root install-strip && \
	post-root /build/autoconf-root && \
	cd /build/autoconf-root && \
	rm -rf usr/share/man usr/share/info && \
	make-deb \
		/build/autoconf-deb \
		/build/autoconf-root \
		/control/autoconf \
		/packages/autoconf_2.69-0_amd64.deb && \
	cd / && \
	rm -rf /build /control /download && \
	opkg --autoremove remove gcc make file linux-devel m4 perl && \
	opkg clean
