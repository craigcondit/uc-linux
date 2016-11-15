FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel autoconf && \
	wget -O /download/automake-1.15.tar.xz \
		http://ftp.gnu.org/gnu/automake/automake-1.15.tar.xz && \
	cd build && \
	tar xf /download/automake-1.15.tar.xz && \
	cd automake-1.15 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/automake-root && \
	make DESTDIR=/build/automake-root install-strip && \
	post-root /build/automake-root && \
	cd /build/automake-root && \
	rm -rf usr/share/man usr/share/info usr/share/doc && \
	rm -f usr/bin/aclocal usr/bin/automake && \
	ln -sf aclocal-1.15 usr/bin/aclocal && \
	ln -sf automake-1.15 usr/bin/automake && \
	make-deb \
		/build/automake-deb \
		/build/automake-root \
		/control/automake \
		/packages/automake_1.15-1_all.deb
