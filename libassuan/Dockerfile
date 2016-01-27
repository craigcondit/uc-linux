FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make linux-devel libgpg-error-devel && \
	opkg clean && \
	wget -O /download/libassuan-2.4.2.tar.bz2 \
		https://www.gnupg.org/ftp/gcrypt/libassuan/libassuan-2.4.2.tar.bz2 && \
	cd /build && \
	tar xf /download/libassuan-2.4.2.tar.bz2 && \
	cd libassuan-2.4.2 && \
	./configure --disable-static --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/libassuan-base-root && \
	make DESTDIR=/build/libassuan-base-root install-strip && \
	post-root /build/libassuan-base-root && \
	cd /build/libassuan-base-root && \
	rm -rf usr/share/info && \

	cp -a /build/libassuan-base-root /build/libassuan-root && \
	cd /build/libassuan-root && \
	rm -rf usr/bin usr/include usr/share && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libassuan-deb \
		/build/libassuan-root \
		/control/libassuan \
		/packages/libassuan_2.4.2-0_amd64.deb && \

	cp -a /build/libassuan-base-root /build/libassuan-devel-root && \
	cd /build/libassuan-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libassuan-devel-deb \
		/build/libassuan-devel-root \
		/control/libassuan-devel \
		/packages/libassuan-devel_2.4.2-0_amd64.deb && \
	
	cd / && \
	rm -rf /build/* /download/* /control/* && \
	opkg install \
		/packages/libassuan_*.deb /packages/libassuan-devel_*.deb

