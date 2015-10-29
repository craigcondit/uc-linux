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
	install -v -d -m755 /usr/share/xml/docbook/xml-dtd-4.5 && \
	install -v -d -m755 /etc/xml && \
	chown -R root:root . && \
	cp -v -af docbook.cat *.dtd ent/ *.mod /usr/share/xml/docbook/xml-dtd-4.5/ && \
	xmlcatalog --noout --create /etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML V4.5//EN" \
		"http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "public" \
		"-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "rewriteSystem" \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		/etc/xml/docbook && \
	xmlcatalog --noout --add "rewriteURI" \
		"http://www.oasis-open.org/docbook/xml/4.5" \
		"file:///usr/share/xml/docbook/xml-dtd-4.5" \
		/etc/xml/docbook && \
	xmlcatalog --noout --create /etc/xml/catalog && \
	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//ENTITIES DocBook XML" \
		"file:///etc/xml/docbook" \
		/etc/xml/catalog && \
	xmlcatalog --noout --add "delegatePublic" \
		"-//OASIS//DTD DocBook XML" \
		"file:///etc/xml/docbook" \
		/etc/xml/catalog && \
	xmlcatalog --noout --add "delegateSystem" \
		"http://www.oasis-open.org/docbook/" \
		"file:///etc/xml/docbook" \
		/etc/xml/catalog && \
	xmlcatalog --noout --add "delegateURI" \
		"http://www.oasis-open.org/docbook/" \
		"file:///etc/xml/docbook" \
		/etc/xml/catalog && \
	pre-root /build/docbook-xml-root && \
	install -v -d -m755 /build/docbook-xml-root/usr/share/xml/docbook/xml-dtd-4.5 && \
	install -v -d -m755 /build/docbook-xml-root/etc/xml && \
	cp -av /etc/xml /build/docbook-xml-root/etc && \
	cp -av /usr/share/xml/docbook/xml-dtd-4.5 /build/docbook-xml-root/usr/share/xml/docbook && \
	post-root /build/docbook-xml-root && \
	make-deb \
		/build/docbook-xml-deb \
		/build/docbook-xml-root \
		/control/docbook-xml \
		/packages/docbook-xml_4.5-0_all.deb

