FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel openssl libssl-devel sed m4 \
		libncurses-devel ncurses-utils openjdk-jdk8 flex libz-devel perl && \
	wget -O /download/otp_src_20.2.tar.gz \
		http://erlang.org/download/otp_src_20.2.tar.gz && \
	cd /build && \
	tar xf /download/otp_src_20.2.tar.gz && \
	cd otp_src_20.2 && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) --disable-static \
		--with-termcap --with-javac --enable-dynamic-ssl-lib \
		--disable-builtin-zlib --with-ssl && \
	MAKE="make -j4" make && \
	pre-root /build/erlang-root && \
	make DESTDIR=/build/erlang-root install && \
	post-root /build/erlang-root && \
	cd /build/erlang-root && \
	(strip --strip-unneeded usr/lib/erlang/bin/* || true) && \
	(strip --strip-unneeded usr/lib/erlang/*/bin/* || true) && \
	(strip --strip-unneeded usr/lib/erlang/lib/*/bin/* || true) && \
	rm -rf usr/lib/erlang/erts*/man && \
	find . -name "*.a" -exec strip --strip-debug "{}" \; && \
	find . -name "*.o" -exec strip --strip-debug "{}" \; && \
	find . -name "*.so" -exec strip --strip-debug "{}" \; && \
	(find . -type d -name "doc" -exec rm -rf "{}" \; || true) && \
	mkdir -p usr/include && \
	cd usr/lib/erlang/usr/include && \
	for file in *.h *.idl ; do \
		ln -sf ../lib/erlang/usr/include/${file} ../../../../include/${file} ; done && \
	cd ../../../../.. && \
	cd usr/lib/erlang/usr/lib && \
	for file in *.a ; do \
		ln -sf erlang/usr/lib/${file} ../../../${file} ; done && \
	cd ../../../../.. && \
	make-deb \
		/build/erlang-deb \
		/build/erlang-root \
		/control/erlang \
		/packages/erlang_20.2.0-1_amd64.deb
