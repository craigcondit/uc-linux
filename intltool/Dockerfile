FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel perl libxml-parser-perl && \
	wget -O /download/intltool-0.51.0.tar.gz \
		http://launchpad.net/intltool/trunk/0.51.0/+download/intltool-0.51.0.tar.gz && \
	cd build && \
	tar xf /download/intltool-0.51.0.tar.gz && \
	cd intltool-0.51.0 && \
	sed -i 's:\\\${:\\\$\\{:' intltool-update.in && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/intltool-root && \
	make DESTDIR=/build/intltool-root install-strip && \
	post-root /build/intltool-root && \
	cd /build/intltool-root && \
	rm -rf usr/share/man && \
	make-deb \
		/build/intltool-deb \
		/build/intltool-root \
		/control/intltool \
		/packages/intltool_0.51.0-1_all.deb

