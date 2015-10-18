FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	(/usr/share/busybox/libexec/busybox \
		addgroup -S www-data|| true) && \
	(/usr/share/busybox/libexec/busybox \
		adduser -h /var/lib/www-data -g '' -s /bin/false \
		-D -S -H -G www-data www-data || true) && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file pkg-config libc-devel libz-devel libssl-devel \
		libpcre-devel libssl-devel && \
	wget -O /download/nginx-1.9.5.tar.gz \
		http://nginx.org/download/nginx-1.9.5.tar.gz && \
	cd /build && \
	tar xf /download/nginx-1.9.5.tar.gz && \
	cd nginx-1.9.5 && \
	./configure \
		--build=$(gcc -dumpmachine) \
		--prefix=/usr/share/nginx \
		--sbin-path=/usr/sbin/nginx \
		--conf-path=/etc/nginx/nginx.conf \
		--pid-path=/var/run/nginx.pid \
		--lock-path=/var/lock/nginx.lock \
		--error-log-path=/var/log/nginx/error.log \
		--http-log-path=/var/log/nginx/access.log \
		--user=www-data \
		--group=www-data \
		--without-mail_pop3_module \
		--without-mail_imap_module \
		--without-mail_smtp_module \
		--without-http_uwsgi_module \
		--without-http_scgi_module \
		--without-http_memcached_module \
		--with-http_ssl_module \
		--with-http_stub_status_module \
		--with-http_v2_module && \
	MAKE="make -j4" make && \
	pre-root /build/nginx-root && \
	make DESTDIR=/build/nginx-root install && \
	post-root /build/nginx-root && \
	cd /build/nginx-root && \
	rm -f etc/nginx/*.default etc/nginx/uwsgi_params && \
	strip --strip-unneeded usr/sbin/nginx && \
	make-deb \
		/build/nginx-deb \
		/build/nginx-root \
		/control/nginx \
		/packages/nginx_1.9.5-0_amd64.deb

