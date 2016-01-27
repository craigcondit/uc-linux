FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file linux-devel libassuan-devel && \
	wget -O /download/libgpg-error-1.21.tar.bz2 \
		https://www.gnupg.org/ftp/gcrypt/libgpg-error/libgpg-error-1.21.tar.bz2 && \
	cd /build && \
	tar xf /download/libgpg-error-1.21.tar.bz2 && \
	cd libgpg-error-1.21 && \
	./configure --disable-static --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/libgpg-error-base-root && \
	make DESTDIR=/build/libgpg-error-base-root install-strip && \
	post-root /build/libgpg-error-base-root && \
	cd /build/libgpg-error-base-root && \
	rm -rf usr/share/info usr/share/locale usr/share/man && \
	rm -rf usr/share/common-lisp && \
	
	cp -a /build/libgpg-error-base-root /build/gpg-error-root && \
	cd /build/gpg-error-root && \
	rm -rf usr/lib usr/share usr/include usr/bin/gpg-error-config && \
	make-deb \
		/build/gpg-error-deb \
		/build/gpg-error-root \
		/control/gpg-error \
		/packages/gpg-error_1.21-0_amd64.deb && \
	
	cp -a /build/libgpg-error-base-root /build/libgpg-error-root && \
	cd /build/libgpg-error-root && \
	rm -rf usr/bin usr/share usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libgpg-error-deb \
		/build/libgpg-error-root \
		/control/libgpg-error \
		/packages/libgpg-error_1.21-0_amd64.deb && \
	
	cp -a /build/libgpg-error-base-root /build/libgpg-error-devel-root && \
	cd /build/libgpg-error-devel-root && \
	rm -f usr/bin/gpg-error usr/lib/*.so* && \
	make-deb \
		/build/libgpg-error-devel-deb \
		/build/libgpg-error-devel-root \
		/control/libgpg-error-devel \
		/packages/libgpg-error-devel_1.21-0_amd64.deb && \

	cd / && \
	rm -rf /build/* /download/* /control/* && \
	opkg install \
		/packages/libgpg-error_*.deb /packages/libgpg-error-devel_*.deb /packages/gpg-error_*.deb

