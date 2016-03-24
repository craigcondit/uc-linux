FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install bash openjdk-jdk8 maven && \
	export JAVA_HOME=/usr/lib/jvm/jdk-8-openjdk-amd64 && \
	wget -O /download/hbase-1.0.3-src.tar.gz \
		http://mirrors.ibiblio.org/apache/hbase/hbase-1.0.3/hbase-1.0.3-src.tar.gz && \
	cd /build && \
	tar xf /download/hbase-1.0.3-src.tar.gz && \
	cd hbase-1.0.3 && \
	mvn -DskipTests clean install assembly:single

RUN \
	pre-root /build/hbase-root && \
	mkdir -p /build/hbase-root/usr/share && \
	cd /build/hbase-root/usr/share && \
	tar xf /build/hbase-1.0.3/hbase-assembly/target/hbase-1.0.3-bin.tar.gz && \
	mv -f hbase-1.0.3 hbase && \
	cd hbase && \
	chown -R root:root . && \
	rm -f LEGAL *.txt && \
	rm -f lib/*tests.jar && \
	mkdir -p /build/hbase-root/etc/hbase && \
	mv -f /build/hbase-root/usr/share/hbase/conf /build/hbase-root/etc/hbase/ && \
	ln -sf /etc/hbase/conf /build/hbase-root/usr/share/hbase/conf && \
	mkdir -p /build/hbase-root/var/log/hbase && \
	rm -rf logs && \
	ln -sf /var/log/hbase /build/hbase-root/usr/share/hbase/logs && \
	echo 'JAVA_HOME="/usr/lib/jvm/jre"' >> /build/hbase-root/etc/hbase/conf/hbase-env.sh && \
	cd /build && \
	mkdir -p /build/hbase-root/usr/bin && \
	echo '#!/bin/sh' > /build/hbase-root/usr/bin/hbase && \
	echo 'export JAVA_HOME=/usr/lib/jvm/jre' >> /build/hbase-root/usr/bin/hbase && \
	echo 'exec /usr/share/hbase/bin/hbase "$@"' >> /build/hbase-root/usr/bin/hbase && \
	chmod 755 /build/hbase-root/usr/bin/hbase && \
	post-root /build/hbase-root && \
	make-deb \
		/build/hbase-deb \
		/build/hbase-root \
		/control/hbase \
		/packages/hbase_1.0.3-0_all.deb

