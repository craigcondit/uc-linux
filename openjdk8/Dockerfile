FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

# setup required build environment
RUN \
	mkdir -p /build /control /download /packages /scripts && \
	opkg update && \
	opkg install \
		libz-devel libbz2-devel libssl-devel gcc make linux-devel \
		unzip zip libgif-devel libalsa-devel libcups-devel libfreetype-devel \
		libx11-all-devel curl file gawk sed bash ncurses-base pkg-config patch openssl cacerts

# this break here is important; causes us to come up with bash as the new shell

# download and unpack sources and bootstrap JDK
RUN \
	curl -Lk https://bitbucket.org/alexkasko/openjdk-unofficial-builds/downloads/openjdk-1.7.0-u80-unofficial-linux-amd64-image.zip > \
		/download/openjdk-1.7.0-u80-unofficial-linux-amd64-image.zip && \
	wget -O /download/jdk8-u121-b13.tar.bz2 \
		http://hg.openjdk.java.net/jdk8u/jdk8u/archive/jdk8u121-b13.tar.bz2 && \
	for subproject in corba hotspot jaxp jaxws langtools jdk nashorn; do \
		wget -O /download/${subproject}.tar.bz2 \
			http://hg.openjdk.java.net/jdk8u/jdk8u/${subproject}/archive/jdk8u121-b13.tar.bz2 ; done && \
	cd /build && \
	unzip /download/openjdk-*.zip && \
	mv openjdk-* openjdk-bootstrap && \
	tar xf /download/jdk8-u121-b13.tar.bz2 && \
	cd jdk8u-jdk8u121-b13 && \
	for subproject in corba hotspot jaxp jaxws langtools jdk nashorn; do \
		tar xf /download/${subproject}.tar.bz2 && \
		mv ${subproject}-* ${subproject} ; done

# build package
ADD scripts /scripts
ADD patches /patches
RUN \
	cp -f /scripts/mkcacerts /download/mkcacerts && \
	chmod 755 /download/mkcacerts && \
	export PATH=/build/openjdk-bootstrap/bin:$PATH && \
	/download/mkcacerts \
		-d "/etc/ssl/certs" \
		-k /build/openjdk-bootstrap/bin/keytool \
		-s /usr/bin/openssl \
		-o /build/cacerts && \
	cd /build/jdk8u-jdk8u121-b13 && \
	patch -p0 < /patches/unpack200-zlib-fix.patch && \
	unset JAVA_HOME && \
	sh ./configure \
		--with-update-version=121 \
		--with-build-number=b13 \
		--with-milestone=uc \
		--enable-unlimited-crypto \
		--with-zlib=system \
		--with-giflib=system \
		--with-stdc++lib=dynamic \
		--with-cacerts-file=/build/cacerts \
		--with-extra-cflags="-std=c++98 -Wno-error -fno-delete-null-pointer-checks -fno-lifetime-dse" \
		--with-extra-cxxflags="-std=c++98 -fno-delete-null-pointer-checks -fno-lifetime-dse" \
		--build="$(gcc -dumpmachine)" && \
	make DEBUG_BINARIES=false SCTP_WERROR= all

# stage install files
RUN \
	cd /build/jdk8u-jdk8u121-b13 && \
	pre-root /build/java-base-root && \
	mkdir -p /build/java-base-root/usr/lib/jvm && \
	cp -a build/*/images/j2sdk-image /build/java-base-root/usr/lib/jvm/jdk-8-openjdk-amd64 && \
	cp -a build/*/images/j2re-image /build/java-base-root/usr/lib/jvm/jre-8-openjdk-amd64 && \
	chown -R root:root /build/java-base-root/usr/lib/jvm && \
	post-root /build/java-base-root && \

	cd /build/java-base-root/usr/lib/jvm/jdk-8-openjdk-amd64 && \
	find . -name '*.diz' -delete && \
	rm -f src.zip ASSEMBLY_EXCEPTION LICENSE THIRD_PARTY_README && \
	rm -f jre/ASSEMBLY_EXCEPTION jre/LICENSE jre/THIRD_PARTY_README && \
	rm -rf demo man sample && \
	for so in $(find . -type f -exec file "{}" \; | grep ELF | sed 's/:.*//' | grep '\.so$'); do ( \
		strip --strip-debug "${so}" || true \
	); done && \
	for so in $(find . -type f -exec file "{}" \; | grep ELF | sed 's/:.*//' | grep -v '\.so$'); do ( \
		strip --strip-unneeded "${so}" || true \
	); done && \
	for cmd in java jjs keytool orbd pack200 policytool rmid rmiregistry servertool tnameserv unpack200 ; do ( \
		rm -f "/bin/${cmd}" && \
		ln -sfv "../jre/bin/${cmd}" "bin/${cmd}" \
	); done && \
	rm -rf jre/lib/applet && \

	cd /build/java-base-root/usr/lib/jvm/jre-8-openjdk-amd64 && \
	find . -name '*.diz' -delete && \
	rm -f ASSEMBLY_EXCEPTION LICENSE THIRD_PARTY_README && \
	rm -rf man && \
	for so in $(find . -type f -exec file "{}" \; | grep ELF | sed 's/:.*//' | grep '\.so$'); do ( \
		strip --strip-debug "${so}" || true \
	); done && \
	for so in $(find . -type f -exec file "{}" \; | grep ELF | sed 's/:.*//' | grep -v '\.so$'); do ( \
		strip --strip-unneeded "${so}" || true \
	); done && \
	rm -rf lib/applet && \
	find . -name '*.diz' -delete && \

	pre-root /build/jdk-root && \
	cd /build/jdk-root && \
	mkdir -p usr/lib/jvm && \
	mv /build/java-base-root/usr/lib/jvm/jdk-8-openjdk-amd64 usr/lib/jvm/ && \
	post-root /build/jdk-root && \

	pre-root /build/jre-root && \
	cd /build/jre-root && \
	mkdir -p usr/lib/jvm && \
	mv /build/java-base-root/usr/lib/jvm/jre-8-openjdk-amd64 usr/lib/jvm/ && \
	post-root /build/jre-root
	
# add control files
ADD control /control

# build deb packages
RUN \
	make-deb \
		/build/openjdk-jdk8-deb \
		/build/jdk-root \
		/control/openjdk-jdk8 \
		/packages/openjdk-jdk8_1.8.0.121-1_amd64.deb && \

	make-deb \
		/build/openjdk-jre8-deb \
		/build/jre-root \
		/control/openjdk-jre8 \
		/packages/openjdk-jre8_1.8.0.121-1_amd64.deb

