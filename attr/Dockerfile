FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel sed gettext-utils && \
	wget -O /download/attr-2.4.47.src.tar.gz \
		http://download.savannah.gnu.org/releases/attr/attr-2.4.47.src.tar.gz && \
	cd /build && \
	tar xf /download/attr-2.4.47.src.tar.gz && \
	cd attr-2.4.47 && \
	sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in && \
	sed -i -e "/SUBDIRS/s|man2||" man/Makefile && \
	./configure --prefix=/usr --disable-static --build=$(gcc -dumpmachine) && \	
	MAKE="make -j4" make && \
	pre-root /build/attr-base-root && \
	make DESTDIR=/build/attr-base-root install install-dev install-lib && \
	post-root /build/attr-base-root && \
	cd /build/attr-base-root && \
	rm -rf usr/share && \
	(strip --strip-debug usr/lib/* || true) && \
	(strip --strip-unneeded usr/bin/* || true) && \

	cp -a /build/attr-base-root /build/attr-root && \
	cd /build/attr-root && \
	rm -rf usr/include usr/lib && \
	make-deb \
		/build/attr-deb \
		/build/attr-root \
		/control/attr \
		/packages/attr_2.4.47-0_amd64.deb && \

	cp -a /build/attr-base-root /build/libattr-root && \
	cd /build/libattr-root && \
	rm -rf usr/bin usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libattr-deb \
		/build/libattr-root \
		/control/libattr \
		/packages/libattr_2.4.47-0_amd64.deb && \

	cp -a /build/attr-base-root /build/libattr-devel-root && \
	cd /build/libattr-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libattr-devel-deb \
		/build/libattr-devel-root \
		/control/libattr-devel \
		/packages/libattr-devel_2.4.47-0_amd64.deb

