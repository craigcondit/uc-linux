FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	wget -O /download/zookeeper-3.4.11.tar.gz \
		http://apache.mirrors.tds.net/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz && \
	cd /build && \
	tar xf /download/zookeeper-3.4.11.tar.gz && \
	cd zookeeper-3.4.11 && \
	chown -R root:root . && \
	pre-root /build/zookeeper-root && \
	mkdir -p /build/zookeeper-root/usr/share/zookeeper && \
	cp -a zookeeper*.jar /build/zookeeper-root/usr/share/zookeeper/ && \
	mkdir -p /build/zookeeper-root/usr/share/zookeeper/lib && \
	cp -a lib/*.jar /build/zookeeper-root/usr/share/zookeeper/lib/ && \	
	mkdir -p /build/zookeeper-root/usr/share/zookeeper/bin && \
	cp -a bin/*.sh /build/zookeeper-root/usr/share/zookeeper/bin/ && \
	mkdir -p /build/zookeeper-root/etc/zookeeper && \
	cp -a conf/log4j.properties /build/zookeeper-root/etc/zookeeper/ && \
	cp -a conf/zoo_sample.cfg /build/zookeeper-root/etc/zookeeper/zoo.cfg && \
	echo 'JVMFLAGS="-Xmx256m"' >> /build/zookeeper-root/etc/zookeeper/java.env && \
	echo "ZOO_LOG_DIR=/var/log/zookeeper" >> /build/zookeeper-root/etc/zookeeper/zookeeper-env.sh && \
	ln -sf ../../../etc/zookeeper /build/zookeeper-root/usr/share/zookeeper/conf && \
	mkdir -p /build/zookeeper-root/var/log/zookeeper && \
	ln -sf ../../../var/log/zookeeper /build/zookeeper-root/usr/share/zookeeper/logs && \
	post-root /build/zookeeper-root && \
	cd /build/zookeeper-root && \
	rm -rf usr/share/man && \
	sed -i 's@/tmp/zookeeper@/var/lib/zookeeper/data@' etc/zookeeper/zoo.cfg && \
	sed -i 's/^#autopurge/autopurge/' etc/zookeeper/zoo.cfg && \
	sed -i 's/autopurge\.purgeInterval=1/autopurge.purgeInterval=24/' etc/zookeeper/zoo.cfg && \
	mkdir -p var/lib/zookeeper/data && \
	make-deb \
		/build/zookeeper-deb \
		/build/zookeeper-root \
		/control/zookeeper \
		/packages/zookeeper_3.4.11-1_all.deb

