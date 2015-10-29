FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libxml2-devel docbook-xml docbook-xsl && \
	wget -O /download/libxslt-1.1.28.tar.gz \
		http://xmlsoft.org/sources/libxslt-1.1.28.tar.gz && \
	cd /build && \
	tar xf /download/libxslt-1.1.28.tar.gz && \
	cd libxslt-1.1.28 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libxslt-base-root && \
	make DESTDIR=/build/libxslt-base-root install-strip && \
	post-root /build/libxslt-base-root && \
	cd /build/libxslt-base-root && \
	rm -rf usr/share/doc usr/share/man && \

	cp -av /build/libxslt-base-root /build/libxslt-root && \
	cd /build/libxslt-root && \
	rm -rf usr/bin usr/include usr/share usr/lib/pkgconfig && \
	rm -f usr/lib/*.la usr/lib/*.sh && \
	make-deb \
		/build/libxslt-deb \
		/build/libxslt-root \
		/control/libxslt \
		/packages/libxslt_1.1.28-0_amd64.deb && \

	cp -av /build/libxslt-base-root /build/libxslt-devel-root && \
	cd /build/libxslt-devel-root && \
	rm -f usr/bin/xsltproc && \
	rm -f usr/lib/*.so* && \
	rmdir usr/lib/libxslt-plugins && \
	make-deb \
		/build/libxslt-devel-deb \
		/build/libxslt-devel-root \
		/control/libxslt-devel \
		/packages/libxslt-devel_1.1.28-0_amd64.deb && \

	cp -av /build/libxslt-base-root /build/xslt-utils-root && \
	cd /build/xslt-utils-root && \
	rm -rf usr/share usr/include usr/lib && \
	rm -f usr/bin/xslt-config && \
	make-deb \
		/build/xslt-utils-deb \
		/build/xslt-utils-root \
		/control/xslt-utils \
		/packages/xslt-utils_1.1.28-0_amd64.deb 

