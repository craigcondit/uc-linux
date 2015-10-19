FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

RUN \
	set -x && \
	umask 022 && \
	LC_ALL=POSIX && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file gawk sed linux-devel libz-devel \
		libgmp-devel libmpfr-devel libmpc-devel libffi-devel zip && \
	wget -O /download/gcc-5.2.0.tar.bz2 \
		http://ftp.gnu.org/gnu/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2 && \
	wget -O /download/ecj-4.9.jar \
		ftp://sourceware.org/pub/java/ecj-4.9.jar && \
	cd /build && \
	tar xf /download/gcc-5.2.0.tar.bz2 && \
	mkdir gcc-build && \
	cd gcc-build && \
	../gcc-5.2.0/configure \
		--prefix=/usr --enable-languages=go --disable-multilib \
		--build="$(gcc -dumpmachine)" \
		--disable-bootstrap --with-system-zlib && \
	MAKE="make -j4" make && \
	pre-root /build/gcc-go-base-root && \
	make DESTDIR=/build/gcc-go-base-root install-strip && \
	post-root /build/gcc-go-base-root

ADD control /control
RUN \
	cd /build/gcc-go-base-root && \
	rm -rf usr/share usr/include && \
	rm -f \
		usr/bin/c++ usr/bin/cpp usr/bin/g++ \
		usr/bin/gcc usr/bin/gcc-ar usr/bin/gcc-nm \
		usr/bin/gcc-ranlib usr/bin/x86_64-uc-linux-gnu-c++ \
		usr/bin/gcov usr/bin/gcov-tool \
		usr/bin/x86_64-uc-linux-gnu-* && \
	rm -f usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/*.o && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/finclude && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include-fixed && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/install-tools && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/plugin && \
	rm -f usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/*.a && \
	rm -f usr/lib/libstdc++*.py && \
	rm -f usr/lib/libsupc++* && \
	rm -rf usr/lib/gcc && \
	mkdir -p usr/lib2 && \
	cp -a usr/lib/libnetgo.* usr/lib/go usr/lib/libgo.* usr/lib/libgobegin.* usr/lib/libgolibbegin.* usr/lib2/ && \	
	rm -rf usr/lib && \
	mv -f usr/lib2 usr/lib && \
	mkdir -p usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new && \
	cp -a \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0/cgo \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0/go1 \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new/ && \
	rm -rf usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0 && \
	mv -f usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0 && \

	cp -a /build/gcc-go-base-root /build/gcc-go-runtime-root && \
	cd /build/gcc-go-runtime-root && \
	rm -f usr/lib/*.a && \
	rm -f usr/lib/*.la && \
	rm -rf usr/libexec && \
	rm -f usr/bin/gccgo && \
	mv -f usr/bin/go usr/bin/go.gcc-go && \
	mv -f usr/bin/gofmt usr/bin/gofmt.gcc-go && \
	make-deb \
		/build/gcc-go-runtime-deb \
		/build/gcc-go-runtime-root \
		/control/gcc-go-runtime \
		/packages/gcc-go-runtime_5.2.0-0_amd64.deb && \

	cp -a /build/gcc-go-base-root /build/gcc-go-devel-root && \
	cd /build/gcc-go-devel-root && \
	rm -rf usr/lib/go && \
	rm -f usr/lib/*.so* && \
	rm -f usr/bin/go usr/bin/gofmt && \
	make-deb \
		/build/gcc-go-devel-deb \
		/build/gcc-go-devel-root \
		/control/gcc-go-devel \
		/packages/gcc-go-devel_5.2.0-0_amd64.deb && \


