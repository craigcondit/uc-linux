FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file linux-devel pkg-config gawk sed \
		libz-devel file libmagic-devel libbz2-devel perl \
		libssl-devel liblzma-devel libarchive-devel curl libcurl-devel \
		libgpg-error-devel libassuan-devel libgpgme-devel m4 \
		autoconf automake libtool && \
	opkg clean && \
	wget -O /download/opkg-0.3.3.tar.gz \
		http://downloads.yoctoproject.org/releases/opkg/opkg-0.3.3.tar.gz && \
	cd /build && \
	tar xf /download/opkg-0.3.3.tar.gz && \
	cd opkg-0.3.3 && \
	./autogen.sh && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static &&\
	MAKE="make -j4" make && \
	pre-root /build/opkg-base-root && \
	make DESTDIR=/build/opkg-base-root install-strip && \
	post-root /build/opkg-base-root && \
	cd /build/opkg-base-root && \
	rm -rf usr/share/man && \

	cp -a /build/opkg-base-root /build/opkg-root && \
	cd /build/opkg-root && \
	rm -rf usr/lib && \
	make-deb \
		/build/opkg-deb \
		/build/opkg-root \
		/control/opkg \
		/packages/opkg_0.3.3-1_amd64.deb && \

	cp -a /build/opkg-base-root /build/libopkg-root && \
	cd /build/libopkg-root && \
	rm -rf usr/bin usr/lib/pkgconfig usr/share && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libopkg-deb \
		/build/libopkg-root \
		/control/libopkg \
		/packages/libopkg_0.3.3-1_amd64.deb && \

	cp -a /build/opkg-base-root /build/libopkg-devel-root && \
	cd /build/libopkg-devel-root && \
	rm -rf usr/bin usr/share && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libopkg-devel-deb \
		/build/libopkg-devel-root \
		/control/libopkg-devel \
		/packages/libopkg-devel_0.3.3-1_amd64.deb

