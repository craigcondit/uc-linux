FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/unzip60.tar.gz \
		http://downloads.sourceforge.net/project/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0/unzip60.tar.gz && \
	cd /build && \
	tar xf /download/unzip60.tar.gz && \
	cd unzip60 && \
	make -f unix/Makefile generic && \
	pre-root /build/unzip-root && \
	make -f unix/Makefile prefix=/build/unzip-root/usr install && \
	post-root /build/unzip-root && \
	cd /build/unzip-root && \
	rm -rf usr/man && \
	(strip --strip-unneeded usr/bin/* || true) && \
	make-deb \
		/build/unzip-deb \
		/build/unzip-root \
		/control/unzip \
		/packages/unzip_6.0-0_amd64.deb && \
	cd / && \
	rm -rf /build /control /download
