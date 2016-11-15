FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel openssl libssl-devel && \
	wget -O /download/ruby-2.3.2.tar.gz \
		https://cache.ruby-lang.org/pub/ruby/2.3/ruby-2.3.2.tar.gz && \
	cd build && \
	tar xf /download/ruby-2.3.2.tar.gz && \
	cd ruby-2.3.2 && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/ruby-root && \
	make DESTDIR=/build/ruby-root install && \
	post-root /build/ruby-root && \
	cd /build/ruby-root && \
	rm -rf usr/share && \
	rm -f usr/lib/*.a && \
	(strip --strip-unneeded usr/bin/* || true) && \
	(find -name "*.so*" -exec strip --strip-debug "{}" \; || true) && \
	make-deb \
		/build/ruby-deb \
		/build/ruby-root \
		/control/ruby \
		/packages/ruby_2.3.2-1_amd64.deb
