FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file patch linux-devel libncurses-devel libreadline-devel && \
	wget -O /download/bash-4.4.tar.gz \
		http://ftp.gnu.org/gnu/bash/bash-4.4.tar.gz && \
	cd build && \
	tar xf /download/bash-4.4.tar.gz && \
	cd bash-4.4 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--bindir=/usr/bin --docdir=/usr/share/doc/bash-4.4 \
		--without-bash-malloc --with-installed-readline && \
	MAKE="make -j4" make && \
	pre-root /build/bash-root && \
	make DESTDIR=/build/bash-root install-strip && \
	post-root /build/bash-root && \
	cd /build/bash-root && \
	rm -rf usr/share && \
	make-deb \
		/build/bash-deb \
		/build/bash-root \
		/control/bash \
		/packages/bash_4.4.0-1_amd64.deb
