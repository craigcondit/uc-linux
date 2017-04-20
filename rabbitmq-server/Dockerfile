FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file linux-devel openssl libssl-devel gawk sed bash ncurses-base \
		coreutils python27 erlang xslt-utils zip unzip python-simplejson rsync grep && \
	opkg clean

RUN \
	wget -O /download/rabbitmq-server-3.6.9.tar.xz \
		https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-3.6.9.tar.xz && \
	cd /build && \
	tar xf /download/rabbitmq-server-3.6.9.tar.xz && \
	cd rabbitmq-server-3.6.9 && \
	MAKE="make -j4" make PREFIX=/usr && \
	pre-root /build/rabbitmq-server-root && \
	make DESTDIR=/build/rabbitmq-server-root PREFIX=/usr install && \
	cp deps/rabbitmq_management/bin/rabbitmqadmin \
		/build/rabbitmq-server-root/usr/sbin/ && \
	chmod 755 /build/rabbitmq-server-root/usr/sbin/rabbitmqadmin && \
	post-root /build/rabbitmq-server-root && \
	cd /build/rabbitmq-server-root && \
	mkdir -p usr/share && \
	ln -sf /usr/lib/erlang/lib/rabbitmq_server-3.6.9 usr/share/rabbitmq && \
	mkdir -p usr/sbin && \
	for cmd in rabbitmq-defaults rabbitmq-env rabbitmq-plugins rabbitmq-server rabbitmqctl ; do \
		ln -sf /usr/share/rabbitmq/sbin/${cmd} usr/sbin/${cmd} ; done && \
	make-deb \
		/build/rabbitmq-server-deb \
		/build/rabbitmq-server-root \
		/control/rabbitmq-server \
		/packages/rabbitmq-server_3.6.9-2_amd64.deb
