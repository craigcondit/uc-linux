FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file pkg-config libc-devel libz-devel \
		libssl-devel libpcre-devel && \
	wget -O /download/haproxy-1.6.0.tar.gz \
		http://www.haproxy.org/download/1.6/src/haproxy-1.6.0.tar.gz && \
	cd /build && \
	tar xf /download/haproxy-1.6.0.tar.gz && \
	cd haproxy-1.6.0 && \
	MAKE="make -j4" make TARGET=linux2628 USE_PCRE=1 USE_OPENSSL=1 USE_ZLIB=1 USE_PCRE_JIT=1 && \
	pre-root /build/haproxy-root && \
	cp haproxy /build/haproxy-root/usr/sbin/ && \
	chmod 755 /build/haproxy-root/usr/sbin/haproxy && \
	post-root /build/haproxy-root && \
	cd /build/haproxy-root && \
	strip --strip-unneeded usr/sbin/haproxy && \
	make-deb \
		/build/haproxy-deb \
		/build/haproxy-root \
		/control/haproxy \
		/packages/haproxy_1.6.0-0_amd64.deb

