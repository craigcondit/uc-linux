FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel m4 perl && \
	wget -O /download/bison-3.0.4.tar.xz \
		http://ftp.gnu.org/gnu/bison/bison-3.0.4.tar.xz && \
	cd build && \
	tar xf /download/bison-3.0.4.tar.xz && \
	cd bison-3.0.4 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/bison-root && \
	make DESTDIR=/build/bison-root install-strip && \
	post-root /build/bison-root && \
	cd /build/bison-root && \
	rm -rf usr/share/man usr/share/info usr/share/doc usr/share/locale  && \
	make-deb \
		/build/bison-deb \
		/build/bison-root \
		/control/bison \
		/packages/bison_3.0.4-0_amd64.deb && \
	cd / && \
	rm -rf /build /control /download && \
	opkg --autoremove remove gcc make file linux-devel m4 perl && \
	opkg clean
