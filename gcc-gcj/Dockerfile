FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
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
	cp /download/ecj-4.9.jar ../gcc-5.2.0/ecj.jar && \
	../gcc-5.2.0/configure \
		--prefix=/usr --enable-languages=java --disable-multilib \
		--build="$(gcc -dumpmachine)" \
		--disable-bootstrap --with-system-zlib && \
	MAKE="make -j4" make && \
	pre-root /build/gcc-gcj-root && \
	make DESTDIR=/build/gcc-gcj-root install-strip && \
	post-root /build/gcc-gcj-root && \
	cd /build/gcc-gcj-root && \
	rm -rf \
		usr/share/info usr/share/locale usr/share/man \
		usr/share/gcc-5.2.0/python/libstdcxx \
		usr/include && \
	rm -f \
		usr/bin/c++ usr/bin/cpp usr/bin/g++ \
		usr/bin/gcc usr/bin/gcc-ar usr/bin/gcc-nm \
		usr/bin/gcc-ranlib usr/bin/x86_64-uc-linux-gnu-c++ \
		usr/bin/gcov usr/bin/gcov-tool \
		usr/bin/x86_64-uc-linux-gnu-* && \
	ln -sf gcj usr/bin/x86_64-uc-linux-gnu-gcj && \
	rm -f usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/*.o && \
	rmdir usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/finclude && \
	mkdir -p usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include2 && \
	for inc in jni_md.h gcj jawt.h jvmpi.h jni.h jawt_md.h ; do \
		cp -a usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include/${inc} \
			usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include2/ ; \
	done && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include && \
	mv usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include2 usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/include-fixed && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/install-tools && \
	rm -rf usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/plugin && \
	rm -f usr/lib/gcc/x86_64-uc-linux-gnu/5.2.0/*.a && \
	mkdir -p usr/lib2 && \
	cp -a usr/lib/libgcj* usr/lib/logging.properties usr/lib/libgij* usr/lib2/ && \
	rm -f usr/lib/lib* usr/lib/logging.properties && \
	cp -a usr/lib2/* usr/lib/ && \
	rm -rf usr/lib2 && \
	mkdir -p usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new && \
	cp -a \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0/ecj1 \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0/jc1 \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0/jvgenmain \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new/ && \
	rm -rf usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0 && \
	mv -f usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0.new \
		usr/libexec/gcc/x86_64-uc-linux-gnu/5.2.0 && \
	make-deb \
		/build/gcc-gcj-deb \
		/build/gcc-gcj-root \
		/control/gcc-gcj \
		/packages/gcc-gcj_5.2.0-0_amd64.deb
