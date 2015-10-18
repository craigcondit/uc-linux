FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config intltool \
		gettext-utils coreutils gperf libcap-devel \
		libblkid-devel libmount-devel libuuid-devel m4 bash

RUN \
	wget -O /download/systemd-224.tar.gz \
		http://anduin.linuxfromscratch.org/sources/other/systemd/systemd-224.tar.xz && \
	cd /build && \
	tar xf /download/systemd-224.tar.gz && \
	cd systemd-224 && \
	cd /build/systemd-224 && \
	./configure \
		--build=$(gcc -dumpmachine) \
		--disable-nls \
		--prefix=/usr --sysconfdir=/etc --localstatedir=/var \
		--with-rootprefix= --with-rootlibdir=/usr/lib \
		--disable-firstboot --disable-ldconfig \
		--without-python --docdir=/usr/share/doc/systemd-224 \
		--with-dbuspolicydir=/etc/dbus-1/system.d \
		--with-dbussessionservicedir=/usr/share/dbus-1/services \
		--with-dbussystemservicedir=/usr/share/dbus-1/system-services && \
	MAKE="make -j4" make

ADD control /control
RUN \
	cd /build/systemd-224 && \
	pre-root /build/systemd-orig-root && \
	make DESTDIR=/build/systemd-orig-root install-strip && \
	post-root /build/systemd-orig-root && \
	cd /build/systemd-orig-root && \
	rm -rf usr/share/rpm usr/lib/rpm usr/share/man usr/share/doc var && \

	cp -a /build/systemd-orig-root /build/systemd-root && \
	cd /build/systemd-root && \
	rm -rf usr/share/pkgconfig && \
	rm -rf usr/include && \
	rm -f usr/lib/*.la usr/lib/*.so* && \
	rm -rf usr/lib/pkgconfig && \
	rm -rf etc/udev usr/lib/udev && \
	rm -f usr/share/zsh/site-functions/_udevadm && \
	rm -f usr/share/bash-completion/completions/udevadm && \
	rm -f usr/bin/udevadm && \
	sed -i "s:0775 root lock:0755 root root:g" usr/lib/tmpfiles.d/legacy.conf && \
	make-deb \
		/build/systemd-deb \
		/build/systemd-root \
		/control/systemd \
		/packages/systemd_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/udev-root && \
	cd /build/udev-root && \
	rm -rf usr/share/pkgconfig && \
	rm -rf usr/include && \
	rm -f usr/lib/*.la usr/lib/*.so* && \
	rm -rf usr/lib/pkgconfig && \
	cp -av etc etc2 && \
	rm -rf etc/* && \
	mv etc2/udev etc/udev && \
	rm -rf etc2 && \
	cp -av usr/lib usr/lib2 && \
	rm -rf usr/lib/* && \
	mv usr/lib2/udev usr/lib/udev && \
	rm -rf usr/lib2 && \
	cp -av usr/share/zsh/site-functions usr/share/zsh/site-functions2 && \
	rm -rf usr/share/zsh/site-functions/* && \
	mv usr/share/zsh/site-functions2/_udevadm usr/share/zsh/site-functions/_udevadm && \
	rm -rf usr/share/zsh/site-functions2 && \
	cp -av usr/share/bash-completion/completions usr/share/bash-completion/completions2 && \
	rm -rf usr/share/bash-completion/completions/* && \
	mv usr/share/bash-completion/completions2/udevadm usr/share/bash-completion/completions/udevadm && \
	rm -rf usr/share/bash-completion/completions2 && \
	cp -av usr/bin usr/bin2 && \
	rm -rf usr/bin/* && \
	mv usr/bin2/udevadm usr/bin/udevadm && \
	rm -rf usr/bin2 && \
	rm -rf usr/share/dbus-1 usr/share/factory usr/share/polkit-1 usr/share/systemd && \

	make-deb \
		/build/systemd-deb \
		/build/systemd-root \
		/control/systemd \
		/packages/systemd_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/libsystemd-root && \
	cd /build/libsystemd-root && \
	rm -rf etc usr/bin usr/share/systemd usr/share/zsh && \
	rm -rf usr/share/bash-completion usr/share/dbus-1 && \
	rm -rf usr/share/factory usr/share/polkit-1 && \
	rm -rf usr/lib/systemd usr/lib/binfmt.d usr/lib/kernel && \
	rm -rf usr/lib/modules-load.d usr/lib/sysctl.d usr/lib/sysusers.d && \
	rm -rf usr/lib/tmpfiles.d usr/lib/udev && \
	rm -rf usr/include usr/lib/pkgconfig usr/share/pkgconfig && \
	rm -rf usr/share && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libnss_* usr/lib/libudev.* && \
	make-deb \
		/build/libsystemd-deb \
		/build/libsystemd-root \
		/control/libsystemd \
		/packages/libsystemd_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/libudev-root && \
	cd /build/libudev-root && \
	rm -rf etc usr/bin usr/share/systemd usr/share/zsh && \
	rm -rf usr/share/bash-completion usr/share/dbus-1 && \
	rm -rf usr/share/factory usr/share/polkit-1 && \
	rm -rf usr/lib/systemd usr/lib/binfmt.d usr/lib/kernel && \
	rm -rf usr/lib/modules-load.d usr/lib/sysctl.d usr/lib/sysusers.d && \
	rm -rf usr/lib/tmpfiles.d usr/lib/udev && \
	rm -rf usr/include usr/lib/pkgconfig usr/share/pkgconfig && \
	rm -rf usr/share && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libnss_* usr/lib/libsystemd.* && \
	make-deb \
		/build/libudev-deb \
		/build/libudev-root \
		/control/libudev \
		/packages/libudev_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/libnss-systemd-root && \
	cd /build/libnss-systemd-root && \
	rm -rf etc usr/bin usr/share/systemd usr/share/zsh && \
	rm -rf usr/share/bash-completion usr/share/dbus-1 && \
	rm -rf usr/share/factory usr/share/polkit-1 && \
	rm -rf usr/lib/systemd usr/lib/binfmt.d usr/lib/kernel && \
	rm -rf usr/lib/modules-load.d usr/lib/sysctl.d usr/lib/sysusers.d && \
	rm -rf usr/lib/tmpfiles.d usr/lib/udev && \
	rm -rf usr/include usr/lib/pkgconfig usr/share/pkgconfig && \
	rm -rf usr/share && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libudev.* usr/lib/libsystemd.* && \
	make-deb \
		/build/libnss-systemd-deb \
		/build/libnss-systemd-root \
		/control/libnss-systemd \
		/packages/libnss-systemd_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/libsystemd-devel-root && \
	cd /build/libsystemd-devel-root && \
	rm -rf etc usr/bin usr/share/systemd usr/share/zsh && \
	rm -rf usr/share/bash-completion usr/share/dbus-1 && \
	rm -rf usr/share/factory usr/share/polkit-1 && \
	rm -rf usr/lib/systemd usr/lib/binfmt.d usr/lib/kernel && \
	rm -rf usr/lib/modules-load.d usr/lib/sysctl.d usr/lib/sysusers.d && \
	rm -rf usr/lib/tmpfiles.d usr/lib/udev && \
	rm -f usr/lib/*.so* && \
	rm -f usr/include/libudev.h usr/share/pkgconfig/udev.pc && \
	rm -f usr/lib/pkgconfig/libudev.pc usr/lib/libudev.la usr/lib/libnss_*.la && \
	make-deb \
		/build/libsystemd-devel-deb \
		/build/libsystemd-devel-root \
		/control/libsystemd-devel \
		/packages/libsystemd-devel_224-0_amd64.deb && \

	cp -a /build/systemd-orig-root /build/libudev-devel-root && \
	cd /build/libudev-devel-root && \
	rm -rf etc usr/bin usr/share/systemd usr/share/zsh && \
	rm -rf usr/share/bash-completion usr/share/dbus-1 && \
	rm -rf usr/share/factory usr/share/polkit-1 && \
	rm -rf usr/lib/systemd usr/lib/binfmt.d usr/lib/kernel && \
	rm -rf usr/lib/modules-load.d usr/lib/sysctl.d usr/lib/sysusers.d && \
	rm -rf usr/lib/tmpfiles.d usr/lib/udev && \
	rm -f usr/lib/*.so* && \
	rm -rf usr/include/systemd && \
	rm -f usr/share/pkgconfig/systemd.pc && \
	rm -f usr/lib/pkgconfig/libsystemd.pc usr/lib/libsystemd.la usr/lib/libnss_*.la && \
	make-deb \
		/build/libudev-devel-deb \
		/build/libudev-devel-root \
		/control/libudev-devel \
		/packages/libudev-devel_224-0_amd64.deb


