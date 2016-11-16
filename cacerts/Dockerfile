FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control

ADD scripts /scripts

RUN \
	mkdir -p /build /control /download /packages /scripts && \
	opkg update && \
	opkg install openssl perl locale-utils locale-data && \
	echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen && \
	opkg remove locale-data && \
	wget -O /download/certdata.txt \
		https://hg.mozilla.org/releases/mozilla-release/raw-file/default/security/nss/lib/ckfw/builtins/certdata.txt && \
	cp -a /scripts/* /download && \
	chmod 755 /download/*.pl /download/*.sh && \
	cd /build && \
	cp -f /download/certdata.txt /build/certdata.txt && \
	/download/make-ca.sh && \
	/download/remove-expired-certs.sh certs && \
	pre-root /build/cacerts-root && \
	install -d /build/cacerts-root/etc/ssl/certs && \
	cp -v certs/*.pem /build/cacerts-root/etc/ssl/certs && \
	c_rehash && \
	install -m 0644 ca-bundle.crt /build/cacerts-root/etc/ssl/ca-bundle.crt && \
	ln -sfv ../ca-bundle.crt /build/cacerts-root/etc/ssl/certs/ca-certificates.crt && \
	post-root /build/cacerts-root && \
	make-deb \
		/build/cacerts-deb \
		/build/cacerts-root \
		/control/cacerts \
		/packages/cacerts_20161104-1_all.deb && \
	cd / && \
	rm -rf /build /control /download
