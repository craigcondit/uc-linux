FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libncurses-devel && \
	wget -O /download/readline-6.3.tar.gz \
		http://ftp.gnu.org/gnu/readline/readline-6.3.tar.gz && \
	wget -O /download/readline-6.3-upstream_fixes-3.patch \
		http://www.linuxfromscratch.org/patches/lfs/systemd/readline-6.3-upstream_fixes-3.patch && \
	cd /build && \
	tar xf /download/readline-6.3.tar.gz && \
	cd readline-6.3 && \
	patch -Np1 -i /download/readline-6.3-upstream_fixes-3.patch && \
	sed -i '/MV.*old/d' Makefile.in && \
	sed -i '/{OLDSUFF}/c:' support/shlib-install && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--disable-static --docdir=/usr/share/doc/readline-6.3 && \
	MAKE="make -j4" make SHLIB_LIBS=-lncurses && \
	pre-root /build/readline-orig-root && \
	make DESTDIR=/build/readline-orig-root SHLIB_LIBS=-lncurses install && \
	post-root /build/readline-orig-root && \
	cd /build/readline-orig-root && \
	rm -rf usr/share && \
	(strip --strip-debug usr/lib/* || true) && \

	cp -a /build/readline-orig-root /build/libreadline-root && \
	cd /build/libreadline-root && \
	rm -rf usr/include && \
	make-deb \
		/build/libreadline-deb \
		/build/libreadline-root \
		/control/libreadline \
		/packages/libreadline_6.3-0_amd64.deb && \

	cp -a /build/readline-orig-root /build/libreadline-devel-root && \
	cd /build/libreadline-devel-root && \
	rm -rf usr/lib && \
	make-deb \
		/build/libreadline-devel-deb \
		/build/libreadline-devel-root \
		/control/libreadline-devel \
		/packages/libreadline-devel_6.3-0_amd64.deb
