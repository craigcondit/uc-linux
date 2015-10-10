FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config && \
	wget -O /download/ncurses-6.0.tar.gz \
		http://ftp.gnu.org/gnu//ncurses/ncurses-6.0.tar.gz && \
	cd build && \
	tar xf /download/ncurses-6.0.tar.gz && \
	cd ncurses-6.0 && \
	sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in && \
	./configure \
		--prefix=/usr --build=$(gcc -dumpmachine) --disable-static \
		--with-shared --mandir=/usr/share/man --without-debug \
		--without-normal --enable-pc-files --enable-widec && \
	MAKE="make -j4" make && \
	pre-root /build/ncurses-orig-root && \
	make DESTDIR=/build/ncurses-orig-root install && \
	post-root /build/ncurses-orig-root && \
	cd /build/ncurses-orig-root && \
	rm -rf usr/share/man && \
	(strip --strip-unneeded usr/bin/* || true) && \
	(strip --strip-debug usr/lib/* || true) && \
	for lib in ncurses form panel menu ; do ( \
		rm -vf usr/lib/lib${lib}.so && \
		echo "INPUT(-l${lib}w)" > usr/lib/lib${lib}.so && \
		ln -sfv ${lib}w.pc usr/lib/pkgconfig/${lib}.pc \
	) ; done && \

	cp -a /build/ncurses-orig-root /build/ncurses-utils-root && \
	cd /build/ncurses-utils-root && \
	rm -rf usr/lib usr/share usr/include && \
	rm -f usr/bin/ncursesw6-config && \
	mv usr/bin/clear usr/bin/clear.ncurses && \
	mv usr/bin/reset usr/bin/reset.ncurses && \
	make-deb \
		/build/ncurses-utils-deb \
		/build/ncurses-utils-root \
		/control/ncurses-utils \
		/packages/ncurses-utils_6.0-0_amd64.deb && \

	cp -a /build/ncurses-orig-root /build/ncurses-base-root && \
	cd /build/ncurses-base-root && \
	rm -rf usr/bin usr/lib usr/include && \
	mkdir usr/lib && \
	ln -sfv ../share/terminfo usr/lib/terminfo && \
	mkdir -p usr/share/terminfo2 && \
	for dir in a c d E h l m p r s v w x ; do \
		mkdir -p usr/share/terminfo2/${dir} ; done && \
	for term in \
		a/ansi c/cons25 c/cons25-debian c/cygwin d/dumb \
		E/Eterm E/Eterm-color h/hurd l/linux m/mach \
		m/mach-bold m/mach-color m/mach-gnu m/mach-gnu-color \
		p/pcansi r/rxvt r/rxvt-basic s/screen s/screen-256color \
		s/screen-256color-bce s/sun v/vt100 v/vt102 v/vt220 \
		v/vt52 w/wsvt25 w/wsvt25m x/xterm x/xterm-256color \
		x/xterm-color x/xterm-r5 x/xterm-r6 x/xterm-vt220 x/xterm-xfree86 ; do \
			cp -H usr/share/terminfo/${term} usr/share/terminfo2/${term} ; done && \
	rm -rf usr/share/terminfo && \
	mv -f usr/share/terminfo2 usr/share/terminfo && \
	make-deb \
		/build/ncurses-base-deb \
		/build/ncurses-base-root \
		/control/ncurses-base \
		/packages/ncurses-base_6.0-0_all.deb && \

	cp -a /build/ncurses-orig-root /build/ncurses-term-root && \
	cd /build/ncurses-term-root && \
	rm -rf usr/bin usr/lib usr/include usr/share/tabset && \
	for term in \
		a/ansi c/cons25 c/cons25-debian c/cygwin d/dumb \
		E/Eterm E/Eterm-color h/hurd l/linux m/mach \
		m/mach-bold m/mach-color m/mach-gnu m/mach-gnu-color \
		p/pcansi r/rxvt r/rxvt-basic s/screen s/screen-256color \
		s/screen-256color-bce s/sun v/vt100 v/vt102 v/vt220 \
		v/vt52 w/wsvt25 w/wsvt25m x/xterm x/xterm-256color \
		x/xterm-color x/xterm-r5 x/xterm-r6 x/xterm-vt220 x/xterm-xfree86 ; do \
			rm -f usr/share/terminfo/${term} ; done && \
	(find usr/share/terminfo -mindepth 1 -type d -delete 2>/dev/null || true) && \
	make-deb \
		/build/ncurses-term-deb \
		/build/ncurses-term-root \
		/control/ncurses-term \
		/packages/ncurses-term_6.0-0_all.deb && \
		
	cp -a /build/ncurses-orig-root /build/libncurses-root && \
	cd /build/libncurses-root && \
	rm -rf usr/bin usr/share usr/include usr/lib/pkgconfig && \
	rm -f usr/lib/terminfo usr/lib/*.a && \
	make-deb \
		/build/libncurses-deb \
		/build/libncurses-root \
		/control/libncurses \
		/packages/libncurses_6.0-0_amd64.deb && \

	cp -a /build/ncurses-orig-root /build/libncurses-devel-root && \
	cd /build/libncurses-devel-root && \
	rm -rf usr/bin usr/share  && \
	rm -f usr/lib/*.so* usr/lib/terminfo && \
	make-deb \
		/build/libncurses-devel-deb \
		/build/libncurses-devel-root \
		/control/libncurses-devel \
		/packages/libncurses-devel_6.0-0_amd64.deb

