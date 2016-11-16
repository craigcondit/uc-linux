FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install make file xml2-utils sgml-common && \
	wget -O /download/docbook-xsl-1.79.1.tar.bz2 \
		http://downloads.sourceforge.net/docbook/docbook-xsl-1.79.1.tar.bz2 && \
	cd /build && \
	tar xf /download/docbook-xsl-1.79.1.tar.bz2 && \
	cd docbook-xsl-1.79.1 && \
	pre-root /build/docbook-xsl-root && \
	install -v -d -m755 /build/docbook-xsl-root/etc/xml && \
	install -v -d -m755 /build/docbook-xsl-root/usr/share/xml/docbook/xsl-stylesheets-1.79.1 && \
	cp -av \
		VERSION common eclipse epub extensions fo highlighting html \
		htmlhelp images javahelp lib manpages params profiling \
		roundtrip slides template tests tools webhelp website \
		xhtml xhtml-1_1 \
		/build/docbook-xsl-root/usr/share/xml/docbook/xsl-stylesheets-1.79.1 && \
	ln -sf VERSION /build/docbook-xsl-root/usr/share/xml/docbook/xsl-stylesheets-1.79.1/VERSION.xsl && \
	install -v -m644 -D README \
		/build/docbook-xsl-root/usr/share/doc/docbook-xsl-1.79.1/README.txt && \
	install -v -m644 RELEASE-NOTES* NEWS* \
		/build/docbook-xsl-root/usr/share/doc/docbook-xsl-1.79.1 && \
	post-root /build/docbook-xsl-root && \
	cd /build/docbook-xsl-root && \
	rm -rf usr/share/doc && \
	make-deb \
		/build/docbook-xsl-deb \
		/build/docbook-xsl-root \
		/control/docbook-xsl \
		/packages/docbook-xsl_1.79.1-1_all.deb

