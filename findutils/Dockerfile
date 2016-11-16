FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/findutils-4.6.0.tar.gz \
		https://ftp.gnu.org/pub/gnu/findutils/findutils-4.6.0.tar.gz && \
	cd build && \
	tar xf /download/findutils-4.6.0.tar.gz && \
	cd findutils-4.6.0 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) \
		--localstatedir=/var/lib/locate && \
	MAKE="make -j4" make && \
	pre-root /build/findutils-root && \
	make DESTDIR=/build/findutils-root install-strip && \
	post-root /build/findutils-root && \
	cd /build/findutils-root && \
	rm -rf usr/share && \
	cd usr/bin && \
	mv -f find find.findutils && \
	mv -f xargs xargs.findutils && \
	cd ../.. && \
	make-deb \
		/build/findutils-deb \
		/build/findutils-root \
		/control/findutils \
		/packages/findutils_4.6.0-1_amd64.deb

