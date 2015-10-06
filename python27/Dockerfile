FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install libz-devel libbz2-devel libssl-devel gcc make file linux-devel && \
	wget -O /download/Python-2.7.10.tar.xz \
		https://www.python.org/ftp/python/2.7.10/Python-2.7.10.tar.xz && \
	cd /build && \
	tar xf /download/Python-2.7.10.tar.xz && \
	cd Python-2.7.10 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) --disable-static \
		--enable-shared --enable-unicode=ucs4 && \
	MAKE="make -j4" make && \
	pre-root /build/python27-base-root && \
	make DESTDIR=/build/python27-base-root install && \
	post-root /build/python27-base-root && \
	cd /build/python27-base-root && \
	rm -rf usr/share && \
	rm -f usr/lib/*.a usr/lib/python2.7/config/*.a && \
	(strip --strip-unneeded usr/bin/* || true) && \
	(find -name "*.so*" -exec strip --strip-debug "{}" \; || true) && \

	cp -a /build/python27-base-root /build/python27-root && \
	cd /build/python27-root && \
	rm -rf usr/include usr/lib/pkgconfig && \
	rm -f usr/bin/python2.7-config usr/bin/python-config usr/bin/python2-config && \
	make-deb \
		/build/python27-deb \
		/build/python27-root \
		/control/python27 \
		/packages/python27_2.7.10-0_amd64.deb && \

	cp -a /build/python27-base-root /build/python27-devel-root && \
	cd /build/python27-devel-root && \
	rm -rf usr/lib/python2.7 && \
	rm -f usr/bin/2to3 usr/bin/idle usr/bin/pydoc usr/bin/python usr/bin/python2 && \
	rm -f usr/bin/python2.7 usr/bin/smtpd.py && \
	make-deb \
		/build/python27-devel-deb \
		/build/python27-devel-root \
		/control/python27-devel \
		/packages/python27-devel_2.7.10-0_amd64.deb
