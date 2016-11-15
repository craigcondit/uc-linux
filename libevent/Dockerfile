FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel libssl-devel && \
	wget -O /download/libevent-2.0.22-stable.tar.gz \
		'https://github.com/libevent/libevent/releases/download/release-2.0.22-stable/libevent-2.0.22-stable.tar.gz' && \
	cd build && \
	tar xf /download/libevent-2.0.22-stable.tar.gz && \
	cd libevent-2.0.22-stable && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --disable-static && \
	MAKE="make -j4" make && \
	pre-root /build/libevent-base-root && \
	make DESTDIR=/build/libevent-base-root install-strip && \
	post-root /build/libevent-base-root && \
	cd /build/libevent-base-root && \
	
	cp -a /build/libevent-base-root /build/libevent-root && \
	cd /build/libevent-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la usr/lib/libevent_* && \
	make-deb \
		/build/libevent-deb \
		/build/libevent-root \
		/control/libevent \
		/packages/libevent_2.0.22-1_amd64.deb && \

	cp -a /build/libevent-base-root /build/libevent-core-root && \
	cd /build/libevent-core-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	find usr/lib -not -type d -not -name 'libevent_core*' -delete && \
	make-deb \
		/build/libevent-core-deb \
		/build/libevent-core-root \
		/control/libevent-core \
		/packages/libevent-core_2.0.22-1_amd64.deb && \

	cp -a /build/libevent-base-root /build/libevent-extra-root && \
	cd /build/libevent-extra-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	find usr/lib -not -type d -not -name 'libevent_extra*' -delete && \
	make-deb \
		/build/libevent-extra-deb \
		/build/libevent-extra-root \
		/control/libevent-extra \
		/packages/libevent-extra_2.0.22-1_amd64.deb && \

	cp -a /build/libevent-base-root /build/libevent-pthreads-root && \
	cd /build/libevent-pthreads-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	find usr/lib -not -type d -not -name 'libevent_pthreads*' -delete && \
	make-deb \
		/build/libevent-pthreads-deb \
		/build/libevent-pthreads-root \
		/control/libevent-pthreads \
		/packages/libevent-pthreads_2.0.22-1_amd64.deb && \

	cp -a /build/libevent-base-root /build/libevent-openssl-root && \
	cd /build/libevent-openssl-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	find usr/lib -not -type d -not -name 'libevent_openssl*' -delete && \
	make-deb \
		/build/libevent-openssl-deb \
		/build/libevent-openssl-root \
		/control/libevent-openssl \
		/packages/libevent-openssl_2.0.22-1_amd64.deb && \

	cp -a /build/libevent-base-root /build/libevent-devel-root && \
	cd /build/libevent-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libevent-devel-deb \
		/build/libevent-devel-root \
		/control/libevent-devel \
		/packages/libevent-devel_2.0.22-1_amd64.deb
