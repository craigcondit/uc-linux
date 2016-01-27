FROM insideo/uc-linux-bootstrap:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
        mkdir -p /build /control /download /packages && \
        opkg update && \
        opkg upgrade && \
	opkg install gcc make file linux-devel pkg-config && \
	opkg clean && \
	wget -O /download/xz-5.2.2.tar.xz \
		http://tukaani.org/xz/xz-5.2.2.tar.xz && \
	cd /build && \
	tar xf /download/xz-5.2.2.tar.xz && \
	cd xz-5.2.2 && \
	./configure \
		--prefix=/usr --disable-static \
		--docdir=/usr/share/doc/xz-5.2.2 && \
	MAKE="make -j4" make && \
	pre-root /build/xz-base-root && \
	make DESTDIR=/build/xz-base-root install-strip && \
	post-root /build/xz-base-root && \
	cd /build/xz-base-root && \
	rm -rf usr/share && \

	cp -a /build/xz-base-root /build/xz-root && \
	cd /build/xz-root && \
	rm -rf usr/lib usr/include && \
	mv usr/bin/lzmadec usr/bin/lzmadec.xz && \
	mv usr/bin/lzmainfo usr/bin/lzmainfo.xz && \
	mv usr/bin/xz usr/bin/xz.xz && \
	mv usr/bin/xzdec usr/bin/xzdec.xz && \
	mv usr/bin/xzdiff usr/bin/xzdiff.xz && \
	mv usr/bin/xzgrep usr/bin/xzgrep.xz && \
	mv usr/bin/xzless usr/bin/xzless.xz && \
	mv usr/bin/xzmore usr/bin/xzmore.xz && \
	rm -f \
		usr/bin/lzcat usr/bin/lzcmp usr/bin/lzdiff \
		usr/bin/lzegrep usr/bin/lzfgrep usr/bin/lzgrep \
		usr/bin/lzless usr/bin/lzma usr/bin/lzmore \
		usr/bin/unlzma usr/bin/unxz usr/bin/xzcat \
		usr/bin/xzcmp usr/bin/xzegrep usr/bin/xzfgrep && \
	make-deb \
		/build/xz-deb \
		/build/xz-root \
		/control/xz \
		/packages/xz_5.2.2-0_amd64.deb && \
		
	cp -a /build/xz-base-root /build/liblzma-root && \
	cd /build/liblzma-root && \
	rm -rf usr/bin usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/liblzma-deb \
		/build/liblzma-root \
		/control/liblzma \
		/packages/liblzma_5.2.2-0_amd64.deb && \
		
	cp -a /build/xz-base-root /build/liblzma-devel-root && \
	cd /build/liblzma-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/liblzma-devel-deb \
		/build/liblzma-devel-root \
		/control/liblzma-devel \
		/packages/liblzma-devel_5.2.2-0_amd64.deb && \
		
	cd / && \
	rm -rf /build/* /download/* /control/* && \
	opkg install \
		/packages/liblzma_*.deb \
		/packages/liblzma-devel_*.deb \
		/packages/xz_*.deb

