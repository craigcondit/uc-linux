FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel && \
	wget -O /download/util-linux-2.27.tar.xz \
		https://www.kernel.org/pub/linux/utils/util-linux/v2.27/util-linux-2.27.tar.xz && \
	cd /build && \
	tar xf /download/util-linux-2.27.tar.xz && \
	cd util-linux-2.27 && \
	./configure \
		ADJTIME_PATH=/var/lib/hwclock/adjtime \
		--docdir=/usr/share/doc/util-linux-2.27 --disable-chfn-chsh \
		--disable-login --disable-nologin --disable-su --disable-setpriv \
		--disable-runuser --disable-pylibmount --disable-static --without-python \
		--build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/util-linux-base-root && \
	make DESTDIR=/build/util-linux-base-root install-strip && \
	post-root /build/util-linux-base-root && \
	cd /build/util-linux-base-root && \
	rm -rf usr/share/doc usr/share/man usr/share/locale && \

	cp -a /build/util-linux-base-root /build/util-linux-root && \
	cd /build/util-linux-root && \
	rm -rf usr/include && \
	for cmd in \
		i386 lastb linux32 linux64 uname26 x86_64 ; do \
		rm "usr/bin/${cmd}" ; done && \
	for cmd in \
		cal chrt col colcrt colrm column dmesg eject \
		fallocate findmnt flock getopt hexdump ionice ipcmk \
		ipcrm ipcs isosize kill last logger look lsblk lscpu \
		lsipc lslocks lslogins mcookie mesg mount mountpoint \
		namei nsenter prlimit rename renice rev script \
		scriptreplay setarch setsid tailf taskset umount \
		unshare utmpdump uuidgen wall wdctl whereis ; do \
		mv "usr/bin/${cmd}" "usr/bin/${cmd}.util-linux" ; done && \
	for cmd in \
		addpart agetty blkdiscard blkid blockdev chcpu \
		ctrlaltdel delpart fdformat fdisk findfs fsck \
		fsck.cramfs fsck.minix fsfreeze fstrim hwclock \
		ldattach losetup mkfs mkfs.bfs mkfs.cramfs mkfs.minix \
		mkswap partx pivot_root raw readprofile resizepart \
		rtcwake sfdisk sulogin swaplabel swapoff swapon \
		switch_root uuidd wipefs zramctl ; do \
		mv "usr/sbin/${cmd}" "usr/sbin/${cmd}.util-linux" ; done && \
	make-deb \
		/build/util-linux-deb \
		/build/util-linux-root \
		/control/util-linux \
		/packages/util-linux_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libblkid-root && \
	cd /build/libblkid-root && \
	rm -rf usr/bin usr/sbin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libfdisk.* usr/lib/libmount.* usr/lib/libsmartcols.* usr/lib/libuuid.* && \
	make-deb \
		/build/libblkid-deb \
		/build/libblkid-root \
		/control/libblkid \
		/packages/libblkid_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libfdisk-root && \
	cd /build/libfdisk-root && \
	rm -rf usr/bin usr/sbin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libblkid.* usr/lib/libmount.* usr/lib/libsmartcols.* usr/lib/libuuid.* && \
	make-deb \
		/build/libfdisk-deb \
		/build/libfdisk-root \
		/control/libfdisk \
		/packages/libfdisk_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libmount-root && \
	cd /build/libmount-root && \
	rm -rf usr/bin usr/sbin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libblkid.* usr/lib/libfdisk.* usr/lib/libsmartcols.* usr/lib/libuuid.* && \
	make-deb \
		/build/libmount-deb \
		/build/libmount-root \
		/control/libmount \
		/packages/libmount_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libsmartcols-root && \
	cd /build/libsmartcols-root && \
	rm -rf usr/bin usr/sbin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libblkid.* usr/lib/libfdisk.* usr/lib/libmount.* usr/lib/libuuid.* && \
	make-deb \
		/build/libsmartcols-deb \
		/build/libsmartcols-root \
		/control/libsmartcols \
		/packages/libsmartcols_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libuuid-root && \
	cd /build/libuuid-root && \
	rm -rf usr/bin usr/sbin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	rm -f usr/lib/libblkid.* usr/lib/libfdisk.* usr/lib/libmount.* usr/lib/libsmartcols.* && \
	make-deb \
		/build/libuuid-deb \
		/build/libuuid-root \
		/control/libuuid \
		/packages/libuuid_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libblkid-devel-root && \
	cd /build/libblkid-devel-root && \
	rm -rf usr/bin usr/sbin usr/share && \
	rm -f usr/lib/*.so* && \
	rm -f \
		usr/lib/libfdisk.la usr/lib/libmount.la \
		usr/lib/libsmartcols.la usr/lib/libuuid.la && \
	rm -f \
		usr/lib/pkgconfig/fdisk.pc usr/lib/pkgconfig/mount.pc \
		usr/lib/pkgconfig/smartcols.pc usr/lib/pkgconfig/uuid.pc && \
	rm -rf \
		usr/include/libfdisk usr/include/libmount \
		usr/include/libsmartcols usr/include/uuid && \
	make-deb \
		/build/libblkid-devel-deb \
		/build/libblkid-devel-root \
		/control/libblkid-devel \
		/packages/libblkid-devel_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libfdisk-devel-root && \
	cd /build/libfdisk-devel-root && \
	rm -rf usr/bin usr/sbin usr/share && \
	rm -f usr/lib/*.so* && \
	rm -f \
		usr/lib/libblkid.la usr/lib/libmount.la \
		usr/lib/libsmartcols.la usr/lib/libuuid.la && \
	rm -f \
		usr/lib/pkgconfig/blkid.pc usr/lib/pkgconfig/mount.pc \
		usr/lib/pkgconfig/smartcols.pc usr/lib/pkgconfig/uuid.pc && \
	rm -rf \
		usr/include/blkid usr/include/libmount \
		usr/include/libsmartcols usr/include/uuid && \
	make-deb \
		/build/libfdisk-devel-deb \
		/build/libfdisk-devel-root \
		/control/libfdisk-devel \
		/packages/libfdisk-devel_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libmount-devel-root && \
	cd /build/libmount-devel-root && \
	rm -rf usr/bin usr/sbin usr/share && \
	rm -f usr/lib/*.so* && \
	rm -f \
		usr/lib/libblkid.la usr/lib/libfdisk.la \
		usr/lib/libsmartcols.la usr/lib/libuuid.la && \
	rm -f \
		usr/lib/pkgconfig/blkid.pc usr/lib/pkgconfig/fdisk.pc \
		usr/lib/pkgconfig/smartcols.pc usr/lib/pkgconfig/uuid.pc && \
	rm -rf \
		usr/include/blkid usr/include/libfdisk \
		usr/include/libsmartcols usr/include/uuid && \
	make-deb \
		/build/libmount-devel-deb \
		/build/libmount-devel-root \
		/control/libmount-devel \
		/packages/libmount-devel_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libsmartcols-devel-root && \
	cd /build/libsmartcols-devel-root && \
	rm -rf usr/bin usr/sbin usr/share && \
	rm -f usr/lib/*.so* && \
	rm -f \
		usr/lib/libblkid.la usr/lib/libfdisk.la \
		usr/lib/libmount.la usr/lib/libuuid.la && \
	rm -f \
		usr/lib/pkgconfig/blkid.pc usr/lib/pkgconfig/fdisk.pc \
		usr/lib/pkgconfig/mount.pc usr/lib/pkgconfig/uuid.pc && \
	rm -rf \
		usr/include/blkid usr/include/libfdisk \
		usr/include/libmount usr/include/uuid && \
	make-deb \
		/build/libsmartcols-devel-deb \
		/build/libsmartcols-devel-root \
		/control/libsmartcols-devel \
		/packages/libsmartcols-devel_2.27-0_amd64.deb && \

	cp -a /build/util-linux-base-root /build/libuuid-devel-root && \
	cd /build/libuuid-devel-root && \
	rm -rf usr/bin usr/sbin usr/share && \
	rm -f usr/lib/*.so* && \
	rm -f \
		usr/lib/libblkid.la usr/lib/libfdisk.la \
		usr/lib/libmount.la usr/lib/libsmartcols.la && \
	rm -f \
		usr/lib/pkgconfig/blkid.pc usr/lib/pkgconfig/fdisk.pc \
		usr/lib/pkgconfig/mount.pc usr/lib/pkgconfig/smartcols.pc && \
	rm -rf \
		usr/include/blkid usr/include/libfdisk \
		usr/include/libmount usr/include/libsmartcols && \
	make-deb \
		/build/libuuid-devel-deb \
		/build/libuuid-devel-root \
		/control/libuuid-devel \
		/packages/libuuid-devel_2.27-0_amd64.deb

