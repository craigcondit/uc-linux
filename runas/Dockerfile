FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD source /source
ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc binutils linux-devel && \
	cd build && \
	mkdir runas && \
	cd runas && \
	cp -av /source/* . && \
	gcc -o runas runas.c && \
	strip --strip-unneeded runas && \
	pre-root /build/runas-root && \
	chown root:root runas && \
	chmod 755 runas && \
	cp -a runas /build/runas-root/usr/bin/runas && \
	post-root /build/runas-root && \
	cd /build/runas-root && \
	make-deb \
		/build/runas-deb \
		/build/runas-root \
		/control/runas \
		/packages/runas_1.0.0-0_amd64.deb
