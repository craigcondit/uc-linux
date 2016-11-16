FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel patch sed && \
	wget -O /download/coreutils-8.25.tar.xz \
		http://ftp.gnu.org/gnu/coreutils/coreutils-8.25.tar.xz && \
	wget -O /download/coreutils-8.25-i18n-2.patch \
		http://www.linuxfromscratch.org/patches/lfs/7.10/coreutils-8.25-i18n-2.patch && \
	cd build && \
	tar xf /download/coreutils-8.25.tar.xz && \
	cd coreutils-8.25 && \
	patch -Np1 -i /download/coreutils-8.25-i18n-2.patch && \
	sed -i '/tests\/misc\/sort.pl/ d' Makefile.in && \
	FORCE_UNSAFE_CONFIGURE=1 ./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) && \
	MAKE="make -j4" make && \
	pre-root /build/coreutils-root && \
	make DESTDIR=/build/coreutils-root install-strip && \
	post-root /build/coreutils-root && \
	cd /build/coreutils-root && \
	rm -rf usr/share && \
	for cmd in \
		\[ base64 basename cat chcon chgrp chmod chown chroot \
		cksum comm cp csplit cut date dd df dir dircolors \
		dirname du echo env expand expr factor false fmt \
		fold groups head hostid id install join kill link \
		ln logname ls md5sum mkdir mkfifo mknod mktemp mv \
		nice nl nohup nproc numfmt od paste pathchk pinky \
		pr printenv printf ptx pwd readlink realpath rm \
		rmdir runcon seq sha1sum sha224sum sha256sum \
		sha384sum sha512sum shred shuf sleep sort split stat \
		stdbuf stty sum sync tac tail tee test timeout touch tr \
		true truncate tsort tty uname unexpand uniq unlink \
		uptime users vdir wc who whoami yes ; do \
		mv "usr/bin/${cmd}" "usr/bin/${cmd}.coreutils" ; done && \
	make-deb \
		/build/coreutils-deb \
		/build/coreutils-root \
		/control/coreutils \
		/packages/coreutils_8.25-1_amd64.deb
