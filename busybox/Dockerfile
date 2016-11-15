FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make linux-devel && \
        wget -O /download/busybox-1.25.1.tar.bz2 \
		http://www.busybox.net/downloads/busybox-1.25.1.tar.bz2 && \
	cd /build && \
	tar xf /download/busybox-1.25.1.tar.bz2 && \
	cd busybox-1.25.1 && \
	confs=' \
		CONFIG_INSTALL_NO_USR \
		CONFIG_AR \
		CONFIG_FEATURE_AR_LONG_FILENAMES \
		CONFIG_FEATURE_AR_CREATE \
		CONFIG_DPKG \
		CONFIG_DPKG_DEB' && \
	make defconfig && \
	for conf in $confs; do \
		sed -i "s!^# $conf is not set\$!$conf=y!" .config; \
		grep -q "^$conf=y" .config || echo "$conf=y" >> .config; \
	done && \
	make oldconfig && \
	for conf in $confs; do grep -q "^$conf=y" .config; done && \
	MAKE="make -j4" make && \
	make install && \
	rm -f _install/linuxrc && \
	mkdir -p /build/busybox-root/usr/bin /build/busybox-root/usr/share/busybox/libexec && \
	cp -a _install/bin/busybox /build/busybox-root/usr/share/busybox/libexec/busybox && \
	cd /build/busybox-root && \
	ln -sfv busybox usr/share/busybox/libexec/sh && \
	chmod 4755 /build/busybox-root/usr/share/busybox/libexec/busybox && \
	make-deb \
		/build/busybox-deb \
		/build/busybox-root \
		/control/busybox \
		/packages/busybox_1.25.1-1_amd64.deb && \
	opkg install /packages/busybox_1.25.1-1_amd64.deb
