FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel perl libexpat-devel && \
	wget -O /download/XML-Parser-2.44_01.tar.gz \
		http://cpan.metacpan.org/authors/id/T/TO/TODDR/XML-Parser-2.44_01.tar.gz && \
	cd build && \
	tar xf /download/XML-Parser-2.44_01.tar.gz && \
	cd XML-Parser-2.44_01 && \
	perl Makefile.PL && \
	MAKE="make -j4" make && \
	pre-root /build/libxml-parser-perl-root && \
	make DESTDIR=/build/libxml-parser-perl-root install && \
	post-root /build/libxml-parser-perl-root && \
	cd /build/libxml-parser-perl-root && \
	rm -rf usr/share usr/lib/perl5/5.24.0 && \
	make-deb \
		/build/libxml-parser-perl-deb \
		/build/libxml-parser-perl-root \
		/control/libxml-parser-perl \
		/packages/libxml-parser-perl_2.44.1-1_amd64.deb

