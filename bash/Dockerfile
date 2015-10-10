FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file patch linux-devel libncurses-devel libreadline-devel && \
	wget -O /download/bash-4.3.30.tar.gz \
		http://ftp.gnu.org/gnu/bash/bash-4.3.30.tar.gz && \
	wget -O /download/bash-4.3.30-upstream_fixes-2.patch \
		http://www.linuxfromscratch.org/patches/lfs/7.8/bash-4.3.30-upstream_fixes-2.patch && \
	cd build && \
	tar xf /download/bash-4.3.30.tar.gz && \
	cd bash-4.3.30 && \
	patch -Np1 -i /download/bash-4.3.30-upstream_fixes-2.patch && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--bindir=/usr/bin --docdir=/usr/share/doc/bash-4.3.30 \
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
		/packages/bash_4.3.30-0_amd64.deb
