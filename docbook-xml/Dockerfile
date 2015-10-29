FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install make file xml2-utils sgml-common unzip && \
	wget -O /download/docbook-xml-4.5.zip \
		http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip && \
	cd /build && \
	mkdir docbook-xml-4.5 && \
	cd docbook-xml-4.5 && \
	unzip /download/docbook-xml-4.5.zip && \
	chown -R root:root . && \
	pre-root /build/docbook-xml-root && \
	install -v -d -m755 /build/docbook-xml-root/usr/share/xml/docbook/xml-dtd-4.5 && \
	install -v -d -m755 /build/docbook-xml-root/etc/xml && \
	cp -v -af docbook.cat *.dtd ent/ *.mod /build/docbook-xml-root/usr/share/xml/docbook/xml-dtd-4.5/ && \
	post-root /build/docbook-xml-root && \
	make-deb \
		/build/docbook-xml-deb \
		/build/docbook-xml-root \
		/control/docbook-xml \
		/packages/docbook-xml_4.5-0_all.deb
