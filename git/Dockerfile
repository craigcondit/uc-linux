FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel perl python27-devel gettext-utils \
		libz-devel libssl-devel libcurl-devel libpcre-devel libexpat-devel && \
	wget -O /download/git-2.6.0.tar.xz \
		https://www.kernel.org/pub/software/scm/git/git-2.6.0.tar.xz && \
	cd /build && \
	tar xf /download/git-2.6.0.tar.xz && \
	cd git-2.6.0 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--with-gitconfig=/etc/gitconfig \
		--with-expat --with-openssl --with-libpcre --without-tcltk && \
	MAKE="make -j4" make NO_INSTALL_HARDLINKS=YesPlease && \
	pre-root /build/git-root && \
	make DESTDIR=/build/git-root NO_INSTALL_HARDLINKS=YesPlease install && \
	post-root /build/git-root && \
	cd /build/git-root && \
	rm -rf usr/share/locale usr/share/man && \
	for cmd in $(find -exec file "{}" \; | grep ELF | grep executable | awk '{print $1}' | sed 's/:$//'); \
		do strip --strip-unneeded $cmd ; done && \
	rm -rf usr/share/man usr/share/info usr/share/doc usr/share/locale  && \
	make-deb \
		/build/git-deb \
		/build/git-root \
		/control/git \
		/packages/git_2.6.0-0_amd64.deb

