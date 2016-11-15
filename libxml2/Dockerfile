FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/libxml2-2.9.4.tar.gz \
		ftp://xmlsoft.org/libxml2/libxml2-2.9.4.tar.gz && \
	cd build && \
	tar xf /download/libxml2-2.9.4.tar.gz && \
	cd libxml2-2.9.4 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libxml2-base-root && \
	make DESTDIR=/build/libxml2-base-root install-strip && \
	post-root /build/libxml2-base-root && \
	cd /build/libxml2-base-root && \
	rm -rf usr/share/doc usr/share/gtk-doc usr/share/man && \

	cp -a /build/libxml2-base-root /build/xml2-utils-root && \
	cd /build/xml2-utils-root && \
	rm -rf usr/include usr/lib usr/share && \
	rm -f usr/bin/xml2-config && \
	make-deb \
		/build/xml2-utils-deb \
		/build/xml2-utils-root \
		/control/xml2-utils \
		/packages/xml2-utils_2.9.4-1_amd64.deb && \

	cp -a /build/libxml2-base-root /build/libxml2-root && \
	cd /build/libxml2-root && \
	rm -rf usr/bin usr/include usr/share usr/lib/pkgconfig usr/lib/cmake && \
	rm usr/lib/*.la usr/lib/*.sh && \
	make-deb \
		/build/libxml2-deb \
		/build/libxml2-root \
		/control/libxml2 \
		/packages/libxml2_2.9.4-1_amd64.deb && \

	cp -a /build/libxml2-base-root /build/libxml2-devel-root && \
	cd /build/libxml2-devel-root && \
	rm -f usr/lib/*.so* && \
	rm -f usr/bin/xmlcatalog usr/bin/xmllint && \
	 
	make-deb \
		/build/libxml2-devel-deb \
		/build/libxml2-devel-root \
		/control/libxml2-devel \
		/packages/libxml2-devel_2.9.4-1_amd64.deb

