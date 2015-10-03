FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control/server-jre-8
RUN \
	SERVER_PATH=8u60-b27 && \
	PACKAGE=server-jre-8u60-linux-x64.tar.gz && \
	PACKAGE_DIR=jdk1.8.0_60 && \
	PACKAGE_VERSION=8u60-0 && \
	mkdir -p /download /build /packages && \
	opkg update && \
	opkg install binutils libgcc && \
	wget --header 'Cookie: oraclelicense=accept-securebackup-cookie' \
		-O /download/${PACKAGE} \
		http://download.oracle.com/otn-pub/java/jdk/${SERVER_PATH}/${PACKAGE} && \
	wget --header 'Cookie: oraclelicense=accept-securebackup-cookie' \
		-O /download/jce_policy-8.zip \
		http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
	cd /build && \
	tar xf /download/${PACKAGE} && \
	chown -R root:root . && \
	unzip /download/jce_policy-8.zip && \
	cd "${PACKAGE_DIR}" && \
	rm -rf man include db && \
	rm -f COPYRIGHT LICENSE README.html \
		THIRDPARTYLICENSEREADME.txt release && \
	(strip --strip-unneeded bin/* || true) && \
	(strip --strip-unneeded lib/jexec || true) && \
	(strip --strip-debug lib/amd64/*.so* lib/amd64/jli/*.so* || true) && \
	rm -f bin/appletviewer bin/java-rmi.cgi bin/policytool && \
	rm -f jre/COPYRIGHT jre/LICENSE jre/README \
		jre/THIRDPARTYLICENSEREADME.txt jre/Welcome.html && \
	(strip --strip-unneeded jre/bin/* || true) && \
	rm -f jre/bin/policytool && \
	for cmd in \
		java jjs keytool orbd pack200 rmid rmiregistry servertool \
		tnameserv unpack200 ; do \
		( rm -f bin/${cmd} && ln -sf ../jre/bin/${cmd} bin/${cmd} ) ; done && \
	(strip --strip-debug \
		jre/lib/amd64/*.so \
		jre/lib/amd64/jli/*.so* \
		jre/lib/amd64/server/*.so* || true) && \
	(strip --strip-unneeded jre/lib/jexec || true) && \
	rm -rf jre/lib/applet jre/lib/fonts jre/lib/images jre/lib/oblique-fonts && \
	rm -rf jre/lib/cmm && \
	rm -f jre/lib/fontconfig* jre/lib/hijrah-config*.properties && \
	rm -f jre/lib/psfont*.properties* && \
	rm -f jre/lib/security/*.jar && \
	cp -a ../UnlimitedJCEPolicyJDK8/*.jar jre/lib/security/ && \
	cd .. && \
	pre-root /build/server-jre-8-root && \
	mkdir -p /build/server-jre-8-root/usr/lib/jvm && \
	mv ${PACKAGE_DIR} /build/server-jre-8-root/usr/lib/jvm/ && \
	cd /build/server-jre-8-root/usr/bin && \
	for cmd in $(find ../lib/jvm/${PACKAGE_DIR}/bin -type f -exec basename "{}" \;) ; do \
		ln -sfv ../lib/jvm/${PACKAGE_DIR}/bin/${cmd} ${cmd} ; done && \
	for cmd in $(find ../lib/jvm/${PACKAGE_DIR}/jre/bin -type f -exec basename "{}" \;) ; do \
		ln -sfv ../lib/jvm/${PACKAGE_DIR}/jre/bin/${cmd} ${cmd} ; done && \
	post-root /build/server-jre-8-root && \
	make-deb \
		/build/server-jre-8-deb \
		/build/server-jre-8-root \
		/control/server-jre-8 \
		/packages/server-jre-8_${PACKAGE_VERSION}_amd64.deb && \
	cd / && \
	rm -rf /build /control /download && \
	opkg remove libgcc binutils && \
	opkg clean
