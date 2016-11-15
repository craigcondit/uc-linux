FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/gettext-0.19.8.1.tar.xz \
		http://ftp.gnu.org/gnu/gettext/gettext-0.19.8.1.tar.xz && \
	cd build && \
	tar xf /download/gettext-0.19.8.1.tar.xz && \
	cd gettext-0.19.8.1 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) \
		--disable-static --docdir=/usr/share/doc/gettext-0.19.8.1 && \
	MAKE="make -j4" make && \
	pre-root /build/gettext-base-root && \
	make DESTDIR=/build/gettext-base-root install-strip && \
	post-root /build/gettext-base-root && \
	cd /build/gettext-base-root && \
	rm -rf usr/share/man usr/share/info usr/share/doc usr/share/locale && \

	cp -a /build/gettext-base-root /build/gettext-common-root && \
	cd /build/gettext-common-root && \
	mkdir -p usr/bin2 && \
	cp -a usr/bin/gettext usr/bin2/ && \
	cp -a usr/bin/ngettext usr/bin2/ && \
	rm -rf usr/bin && \
	mv -f usr/bin2 usr/bin && \
	rm -rf usr/lib usr/include usr/share/aclocal && \		
	make-deb \
		/build/gettext-common-deb \
		/build/gettext-common-root \
		/control/gettext-common \
		/packages/gettext-common_0.19.8.1-1_amd64.deb && \

	cp -a /build/gettext-base-root /build/gettext-utils-root && \
	cd /build/gettext-utils-root && \
	rm -f usr/bin/gettext usr/bin/ngettext && \
	rm -rf usr/lib usr/include usr/share && \
	make-deb \
		/build/gettext-utils-deb \
		/build/gettext-utils-root \
		/control/gettext-utils \
		/packages/gettext-utils_0.19.8.1-1_amd64.deb && \

	cp -a /build/gettext-base-root /build/libgettext-root && \
	cd /build/libgettext-root && \
	rm -rf usr/bin usr/include usr/share && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libgettext-deb \
		/build/libgettext-root \
		/control/libgettext \
		/packages/libgettext_0.19.8.1-1_amd64.deb && \

	cp -a /build/gettext-base-root /build/libgettext-devel-root && \
	cd /build/libgettext-devel-root && \
	rm -rf usr/bin usr/lib/gettext usr/share/gettext && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libgettext-devel-deb \
		/build/libgettext-devel-root \
		/control/libgettext-devel \
		/packages/libgettext-devel_0.19.8.1-1_amd64.deb

