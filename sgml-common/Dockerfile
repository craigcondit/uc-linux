FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install make file autoconf automake patch && \
	wget -O /download/sgml-common-0.6.3.tgz \
		ftp://sources.redhat.com/pub/docbook-tools/new-trials/SOURCES/sgml-common-0.6.3.tgz && \
	wget -O /download/sgml-common-0.6.3-manpage-1.patch \
		http://www.linuxfromscratch.org/patches/blfs/svn/sgml-common-0.6.3-manpage-1.patch && \
	cd /build && \
	tar xf /download/sgml-common-0.6.3.tgz && \
	cd sgml-common-0.6.3 && \
	patch -Np1 -i /download/sgml-common-0.6.3-manpage-1.patch && \
	autoreconf -f -i && \
	./configure --prefix=/usr --build=$(gcc -dumpmachine) --sysconfdir=/etc && \
	MAKE="make -j4" make && \
	pre-root /build/sgml-common-root && \
	make DESTDIR=/build/sgml-common-root docdir=/usr/share/doc install && \
	post-root /build/sgml-common-root && \
	cd /build/sgml-common-root && \
	rm -rf usr/share/doc usr/share/man && \
	cp -av . / && \
	install-catalog --add /etc/sgml/sgml-ent.cat /usr/share/sgml/sgml-iso-entities-8879.1986/catalog && \
	install-catalog --add /etc/sgml/sgml-docbook.cat /etc/sgml/sgml-ent.cat && \
	cp -av /etc/sgml/* etc/sgml/ && \
	make-deb \
		/build/sgml-common-deb \
		/build/sgml-common-root \
		/control/sgml-common \
		/packages/sgml-common_0.6.3-0_all.deb

