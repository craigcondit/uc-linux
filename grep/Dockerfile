FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libpcre-devel pkg-config && \
	wget -O /download/grep-2.26.tar.xz \
		http://ftp.gnu.org/gnu/grep/grep-2.26.tar.xz && \
	cd /build && \
	tar xf /download/grep-2.26.tar.xz && \
	cd grep-2.26 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/grep-root && \
	make DESTDIR=/build/grep-root install && \
	post-root /build/grep-root && \
	cd /build/grep-root && \
	rm -rf usr/share && \
	(strip --strip-unneeded usr/bin/* || true) && \
	mv usr/bin/grep usr/bin/grep.grep && \
	mv usr/bin/egrep usr/bin/egrep.grep && \
	mv usr/bin/fgrep usr/bin/fgrep.grep && \
	make-deb \
		/build/grep-deb \
		/build/grep-root \
		/control/grep \
		/packages/grep-2.26-1_amd64.deb && \
	cd / && \
	rm -rf /build /control /download

