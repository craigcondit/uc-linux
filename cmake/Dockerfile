FROM insideo/uc-linux-bootstrap:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install \
		gcc make file linux-devel pkg-config \
		libcurl-devel libarchive-devel libz-devel \
		libbz2-devel libexpat-devel libuv-devel \
		liblzma-devel libncurses-devel && \
	wget -O /download/cmake-3.7.0.tar.gz \
		http://www.cmake.org/files/v3.7/cmake-3.7.0.tar.gz && \
	cd build && \
	tar xf /download/cmake-3.7.0.tar.gz && \
	cd cmake-3.7.0 && \
	./bootstrap \
		--prefix=/usr \
		--system-libs \
		--mandir=/share/man \
		--no-system-jsoncpp \
		--docdir=/share/doc/cmake && \
	MAKE="make -j4" make && \
	pre-root /build/cmake-root && \
	make DESTDIR=/build/cmake-root install && \
	post-root /build/cmake-root && \
	cd /build/cmake-root && \
	rm -rf usr/share/doc usr/share/cmake-*/Help && \
	strip usr/bin/* && \

	make-deb \
		/build/cmake-deb \
		/build/cmake-root \
		/control/cmake \
		/packages/cmake_3.7.0-1_amd64.deb

