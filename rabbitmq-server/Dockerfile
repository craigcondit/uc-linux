FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel openssl libssl-devel \
		coreutils python27 erlang xslt-utils zip unzip python-simplejson && \
	wget -O /download/rabbitmq-server-3.5.6.tar.gz \
		https://www.rabbitmq.com/releases/rabbitmq-server/v3.5.6/rabbitmq-server-3.5.6.tar.gz && \
	cd /build && \
	tar xf /download/rabbitmq-server-3.5.6.tar.gz && \
	cd rabbitmq-server-3.5.6 && \
	sed -i 's/nc -z/nc/' plugins-src/rabbitmq-auth-backend-ldap/package.mk && \
	MAKE="make -j4" make && \
	pre-root /build/rabbitmq-server-root && \
	make \
		TARGET_DIR=/build/rabbitmq-server-root/usr/share/rabbitmq \
		MAN_DIR=/build/rabbitmq-server-root/usr/share/man \
		BIN_DIR=/build/rabbitmq-server-root/usr/bin \
		SBIN_DIR=/build/rabbitmq-server-root/usr/sbin \
		install_bin && \
	cp -a plugins-src/rabbitmq-management/bin/rabbitmqadmin \
		/build/rabbitmq-server-root/usr/sbin/ && \
	post-root /build/rabbitmq-server-root && \
	cd /build/rabbitmq-server-root && \
	rm -rf usr/share/man && \
	make-deb \
		/build/rabbitmq-server-deb \
		/build/rabbitmq-server-root \
		/control/rabbitmq-server \
		/packages/rabbitmq-server_3.5.6-0_amd64.deb
