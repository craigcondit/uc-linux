FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install locale-utils locale-data && \
	echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen && \
	opkg remove locale-data && \
	export LC_ALL=en_US.UTF-8 && \
	opkg install gcc make file linux-devel openssl libssl-devel gawk sed bash ncurses-base \
		coreutils python27 erlang elixir xslt-utils zip unzip python-simplejson \
		rsync grep && \
	opkg clean

RUN \
	export LC_ALL=en_US.UTF-8 && \
	wget -O /download/rabbitmq-server-3.7.2.tar.xz \
		https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.7.2/rabbitmq-server-3.7.2.tar.xz && \
	cd /build && \
	tar xf /download/rabbitmq-server-3.7.2.tar.xz && \
	cd rabbitmq-server-3.7.2 && \
	MAKE="make -j4" make PREFIX=/usr && \
	pre-root /build/rabbitmq-server-root && \
	make DESTDIR=/build/rabbitmq-server-root PREFIX=/usr install && \
	cp deps/rabbitmq_management/bin/rabbitmqadmin \
		/build/rabbitmq-server-root/usr/sbin/ && \
	chmod 755 /build/rabbitmq-server-root/usr/sbin/rabbitmqadmin && \
	post-root /build/rabbitmq-server-root && \
	cd /build/rabbitmq-server-root && \
	mkdir -p usr/share && \
	ln -sf /usr/lib/erlang/lib/rabbitmq_server-3.7.2 usr/share/rabbitmq && \
	mkdir -p usr/sbin && \
	for cmd in rabbitmq-defaults rabbitmq-env rabbitmq-plugins rabbitmq-server rabbitmqctl ; do \
		ln -sf /usr/share/rabbitmq/sbin/${cmd} usr/sbin/${cmd} ; done && \
	make-deb \
		/build/rabbitmq-server-deb \
		/build/rabbitmq-server-root \
		/control/rabbitmq-server \
		/packages/rabbitmq-server_3.7.2-1_amd64.deb
