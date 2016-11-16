FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

RUN \
	set -x && \
	umask 022 && \
	LC_ALL=POSIX && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file pkg-config libc-devel libz-devel patch gawk && \
	wget -O /download/glibc-2.24.tar.xz \
		http://ftp.gnu.org/gnu/glibc/glibc-2.24.tar.xz && \
	wget -O /download/glibc-2.24-fhs-1.patch \
		http://www.linuxfromscratch.org/patches/lfs/7.10/glibc-2.24-fhs-1.patch && \
	cd /build && \
	tar xf /download/glibc-2.24.tar.xz && \
	cd glibc-2.24 && \
	patch -Np1 -i /download/glibc-2.24-fhs-1.patch && \
	mkdir -p ../glibc-build && \
	cd ../glibc-build && \
	../glibc-2.24/configure \
		--prefix=/usr --disable-profile --enable-kernel=2.6.32\
		--enable-obsolete-rpc && \
	MAKE="make -j4" make && \
	pre-root /build/glibc-root && \
	touch /build/glibc-root/etc/ld.so.conf && \
	make install_root=/build/glibc-root install && \
	rm -f /build/glibc-root/etc/ld.so.conf && \
	post-root /build/glibc-root

ADD support /support
ADD control /control
RUN \

	pre-root /build/locale-utils-root && \
	cd /build/locale-utils-root && \
	cp -a /build/glibc-root/usr/bin/locale usr/bin/ && \
	cp -a /build/glibc-root/usr/bin/localedef usr/bin/ && \
	mkdir -p usr/share/locale && \
	cat /build/glibc-2.24/localedata/SUPPORTED | grep -v ^# \
		| grep -v ^SUPPORTED | sed 's/ \\//' | sed 's@/@ @' \
		> usr/share/locale/SUPPORTED && \
	cat /build/glibc-2.24/localedata/SUPPORTED | grep -v ^# \
		| grep -v ^SUPPORTED | sed 's/ \\//' | sed 's/^/# /' | sed 's@/@ @' \
		> etc/locale.gen && \
	cp /support/locale-gen usr/sbin && \
	chmod 755 usr/sbin/locale-gen && \
	(strip --strip-unneeded usr/bin/* || true) && \
	mkdir -p usr/share/locale && \
	cp -a /build/glibc-root/usr/share/locale/* usr/share/locale && \
	cp -a /build/glibc-root/usr/share/i18n usr/share/i18n && \	
	post-root /build/locale-utils-root && \

	cp -a /build/locale-utils-root /build/locale-data-root && \

	cd /build/locale-utils-root && \
	rm -rf usr/share && \
	make-deb \
		/build/locale-utils-deb \
		/build/locale-utils-root \
		/control/locale-utils \
		/packages/locale-utils_2.24-1_amd64.deb && \

	cd /build/locale-data-root && \
	rm -rf usr/bin usr/sbin etc && \
	make-deb \
		/build/locale-data-deb \
		/build/locale-data-root \
		/control/locale-data \
		/packages/locale-data_2.24-1_all.deb

