FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD scripts /scripts
RUN \
	set +x && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel pkg-config x11-util-macros fontconfig-utils libfontconfig-devel x11-proto-devel libx11-xau-devel libx11-xcb-devel gettext-utils libgettext-devel && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	for pkg in $(grep -v '^#' /scripts/manifest | awk '{print $2}'); do \
		wget -O /download/${pkg} http://ftp.x.org/pub/individual/lib/${pkg} ; done && \
	cd /download && \
	md5sum -c /scripts/manifest && \
	cd /build && \
	for pkg in $(grep -v '^#' /scripts/manifest | awk '{print $2}'); do ( \
		pkgdir=${pkg%.tar.bz2} && \
		cd /build && \
		tar xf "/download/${pkg}" && \
		cd "/build/${pkgdir}" && \
		cd /build \
	) ; done

# xtrans
ADD control/xtrans /control/xtrans
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \	
	cd xtrans-1.3.5 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \	
	pre-root /build/libx11-xtrans-devel-root && \
	make DESTDIR=/build/libx11-xtrans-devel-root install-strip && \	
	post-root /build/libx11-xtrans-devel-root && \
	cd /build/libx11-xtrans-devel-root && \
	rm -rf usr/share/doc && \
	make-deb \
		/build/libx11-xtrans-devel-deb \
		/build/libx11-xtrans-devel-root \
		/control/xtrans/libx11-xtrans-devel \
		/packages/libx11-xtrans-devel_1.3.5-1_all.deb && \
	opkg install /packages/libx11-xtrans-devel_*.deb

# libx11
ADD control/libx11 /control/libx11
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \	
	cd libX11-1.6.4 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \	
	pre-root /build/libx11-base-root && \
	make DESTDIR=/build/libx11-base-root install-strip && \	
	post-root /build/libx11-base-root && \
	cd /build/libx11-base-root && \
	rm -rf usr/share && \

	cp -a /build/libx11-base-root /build/libx11-root && \
	cd /build/libx11-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-deb \
		/build/libx11-root \
		/control/libx11/libx11 \
		/packages/libx11_1.6.4-1_amd64.deb && \

	cp -a /build/libx11-base-root /build/libx11-devel-root && \
	cd /build/libx11-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-devel-deb \
		/build/libx11-devel-root \
		/control/libx11/libx11-devel \
		/packages/libx11-devel_1.6.4-1_amd64.deb && \

	opkg install \
		/packages/libx11_*.deb /packages/libx11-devel_*.deb

# libXext
ADD control/libx11-xext /control/libx11-xext
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \	
	cd libXext-1.3.3 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \	
	pre-root /build/libx11-xext-base-root && \
	make DESTDIR=/build/libx11-xext-base-root install-strip && \	
	post-root /build/libx11-xext-base-root && \
	cd /build/libx11-xext-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xext-base-root /build/libx11-xext-root && \
	cd /build/libx11-xext-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xext-deb \
		/build/libx11-xext-root \
		/control/libx11-xext/libx11-xext \
		/packages/libx11-xext_1.3.3-1_amd64.deb && \

	cp -a /build/libx11-xext-base-root /build/libx11-xext-devel-root && \
	cd /build/libx11-xext-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xext-devel-deb \
		/build/libx11-xext-devel-root \
		/control/libx11-xext/libx11-xext-devel \
		/packages/libx11-xext-devel_1.3.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-xext_*.deb /packages/libx11-xext-devel_*.deb

# libFS
ADD control/libx11-fs /control/libx11-fs
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \	
	cd libFS-1.0.7 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \	
	pre-root /build/libx11-fs-base-root && \
	make DESTDIR=/build/libx11-fs-base-root install-strip && \
	post-root /build/libx11-fs-base-root && \
	cd /build/libx11-fs-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-fs-base-root /build/libx11-fs-root && \
	cd /build/libx11-fs-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-fs-deb \
		/build/libx11-fs-root \
		/control/libx11-fs/libx11-fs \
		/packages/libx11-fs_1.0.7-1_amd64.deb && \

	cp -a /build/libx11-fs-base-root /build/libx11-fs-devel-root && \
	cd /build/libx11-fs-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-fs-devel-deb \
		/build/libx11-fs-devel-root \
		/control/libx11-fs/libx11-fs-devel \
		/packages/libx11-fs-devel_1.0.7-1_amd64.deb && \

	opkg install \
		/packages/libx11-fs_*.deb /packages/libx11-fs-devel_*.deb

# libICE
ADD control/libx11-ice /control/libx11-ice
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libICE-1.0.9 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-ice-base-root && \
	make DESTDIR=/build/libx11-ice-base-root install-strip && \
	post-root /build/libx11-ice-base-root && \
	cd /build/libx11-ice-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-ice-base-root /build/libx11-ice-root && \
	cd /build/libx11-ice-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-ice-deb \
		/build/libx11-ice-root \
		/control/libx11-ice/libx11-ice \
		/packages/libx11-ice_1.0.9-1_amd64.deb && \

	cp -a /build/libx11-ice-base-root /build/libx11-ice-devel-root && \
	cd /build/libx11-ice-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-ice-devel-deb \
		/build/libx11-ice-devel-root \
		/control/libx11-ice/libx11-ice-devel \
		/packages/libx11-ice-devel_1.0.9-1_amd64.deb && \

	opkg install \
		/packages/libx11-ice_*.deb /packages/libx11-ice-devel_*.deb

# libSM
ADD control/libx11-sm /control/libx11-sm
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libSM-1.2.2 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-sm-base-root && \
	make DESTDIR=/build/libx11-sm-base-root install-strip && \
	post-root /build/libx11-sm-base-root && \
	cd /build/libx11-sm-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-sm-base-root /build/libx11-sm-root && \
	cd /build/libx11-sm-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-sm-deb \
		/build/libx11-sm-root \
		/control/libx11-sm/libx11-sm \
		/packages/libx11-sm_1.2.2-1_amd64.deb && \

	cp -a /build/libx11-sm-base-root /build/libx11-sm-devel-root && \
	cd /build/libx11-sm-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-sm-devel-deb \
		/build/libx11-sm-devel-root \
		/control/libx11-sm/libx11-sm-devel \
		/packages/libx11-sm-devel_1.2.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-sm_*.deb /packages/libx11-sm-devel_*.deb

# libXScrnSaver
ADD control/libx11-xscreensaver /control/libx11-xscreensaver
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXScrnSaver-1.2.2 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xscreensaver-base-root && \
	make DESTDIR=/build/libx11-xscreensaver-base-root install-strip && \
	post-root /build/libx11-xscreensaver-base-root && \
	cd /build/libx11-xscreensaver-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xscreensaver-base-root /build/libx11-xscreensaver-root && \
	cd /build/libx11-xscreensaver-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xscreensaver-deb \
		/build/libx11-xscreensaver-root \
		/control/libx11-xscreensaver/libx11-xscreensaver \
		/packages/libx11-xscreensaver_1.2.2-1_amd64.deb && \

	cp -a /build/libx11-xscreensaver-base-root /build/libx11-xscreensaver-devel-root && \
	cd /build/libx11-xscreensaver-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xscreensaver-devel-deb \
		/build/libx11-xscreensaver-devel-root \
		/control/libx11-xscreensaver/libx11-xscreensaver-devel \
		/packages/libx11-xscreensaver-devel_1.2.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-xscreensaver_*.deb /packages/libx11-xscreensaver-devel_*.deb

# libXt
ADD control/libx11-xt /control/libx11-xt
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
		--localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXt-1.1.5 && \
	./configure $XORG_CONFIG \
		--with-appdefaultdir=/etc/X11/app-defaults && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xt-base-root && \
	make DESTDIR=/build/libx11-xt-base-root install-strip && \
	post-root /build/libx11-xt-base-root && \
	cd /build/libx11-xt-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xt-base-root /build/libx11-xt-root && \
	cd /build/libx11-xt-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xt-deb \
		/build/libx11-xt-root \
		/control/libx11-xt/libx11-xt \
		/packages/libx11-xt_1.1.5-1_amd64.deb && \

	cp -a /build/libx11-xt-base-root /build/libx11-xt-devel-root && \
	cd /build/libx11-xt-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xt-devel-deb \
		/build/libx11-xt-devel-root \
		/control/libx11-xt/libx11-xt-devel \
		/packages/libx11-xt-devel_1.1.5-1_amd64.deb && \

	opkg install \
		/packages/libx11-xt_*.deb /packages/libx11-xt-devel_*.deb

# libXmu
ADD control/libx11-xmu /control/libx11-xmu
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
		--localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXmu-1.1.2 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xmu-base-root && \
	make DESTDIR=/build/libx11-xmu-base-root install-strip && \
	post-root /build/libx11-xmu-base-root && \
	cd /build/libx11-xmu-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xmu-base-root /build/libx11-xmu-root && \
	cd /build/libx11-xmu-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xmu-deb \
		/build/libx11-xmu-root \
		/control/libx11-xmu/libx11-xmu \
		/packages/libx11-xmu_1.1.2-1_amd64.deb && \

	cp -a /build/libx11-xmu-base-root /build/libx11-xmu-devel-root && \
	cd /build/libx11-xmu-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xmu-devel-deb \
		/build/libx11-xmu-devel-root \
		/control/libx11-xmu/libx11-xmu-devel \
		/packages/libx11-xmu-devel_1.1.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-xmu_*.deb /packages/libx11-xmu-devel_*.deb

# libXpm
ADD control/libx11-xpm /control/libx11-xpm
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
		--localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXpm-3.5.11 && \
	./configure $XORG_CONFIG --without-gettext && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xpm-base-root && \
	make DESTDIR=/build/libx11-xpm-base-root install-strip && \
	post-root /build/libx11-xpm-base-root && \
	cd /build/libx11-xpm-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xpm-base-root /build/xpm-utils-root && \
	cd /build/xpm-utils-root && \
	rm -rf usr/lib usr/include && \
	make-deb \
		/build/xpm-utils-deb \
		/build/xpm-utils-root \
		/control/libx11-xpm/xpm-utils \
		/packages/xpm-utils_3.5.11-1_amd64.deb && \

	cp -a /build/libx11-xpm-base-root /build/libx11-xpm-root && \
	cd /build/libx11-xpm-root && \
	rm -rf usr/bin usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xpm-deb \
		/build/libx11-xpm-root \
		/control/libx11-xpm/libx11-xpm \
		/packages/libx11-xpm_3.5.11-1_amd64.deb && \

	cp -a /build/libx11-xpm-base-root /build/libx11-xpm-devel-root && \
	cd /build/libx11-xpm-devel-root && \
	rm -rf usr/bin && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xpm-devel-deb \
		/build/libx11-xpm-devel-root \
		/control/libx11-xpm/libx11-xpm-devel \
		/packages/libx11-xpm-devel_3.5.11-1_amd64.deb && \

	opkg install \
		/packages/libx11-xpm_*.deb \
		/packages/xpm-utils_*.deb \
		/packages/libx11-xpm-devel_*.deb

# libXaw
ADD control/libx11-xaw /control/libx11-xaw
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc \
		--localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXaw-1.0.13 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xaw-base-root && \
	make DESTDIR=/build/libx11-xaw-base-root install-strip && \
	post-root /build/libx11-xaw-base-root && \
	cd /build/libx11-xaw-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xaw-base-root /build/libx11-xaw-root && \
	cd /build/libx11-xaw-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xaw-deb \
		/build/libx11-xaw-root \
		/control/libx11-xaw/libx11-xaw \
		/packages/libx11-xaw_1.0.13-1_amd64.deb && \

	cp -a /build/libx11-xaw-base-root /build/libx11-xaw-devel-root && \
	cd /build/libx11-xaw-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xaw-devel-deb \
		/build/libx11-xaw-devel-root \
		/control/libx11-xaw/libx11-xaw-devel \
		/packages/libx11-xaw-devel_1.0.13-1_amd64.deb && \

	opkg install \
		/packages/libx11-xaw_*.deb /packages/libx11-xaw-devel_*.deb

# libXfixes
ADD control/libx11-xfixes /control/libx11-xfixes
RUN \
	set +x && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc  --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	cd /build && \
	cd libXfixes-5.0.3 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xfixes-base-root && \
	make DESTDIR=/build/libx11-xfixes-base-root install-strip && \
	post-root /build/libx11-xfixes-base-root && \
	cd /build/libx11-xfixes-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xfixes-base-root /build/libx11-xfixes-root && \
	cd /build/libx11-xfixes-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xfixes-deb \
		/build/libx11-xfixes-root \
		/control/libx11-xfixes/libx11-xfixes \
		/packages/libx11-xfixes_5.0.3-1_amd64.deb && \

	cp -a /build/libx11-xfixes-base-root /build/libx11-xfixes-devel-root && \
	cd /build/libx11-xfixes-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xfixes-devel-deb \
		/build/libx11-xfixes-devel-root \
		/control/libx11-xfixes/libx11-xfixes-devel \
		/packages/libx11-xfixes-devel_5.0.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-xfixes_*.deb /packages/libx11-xfixes-devel_*.deb

# libXcomposite
ADD control/libx11-xcomposite /control/libx11-xcomposite
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXcomposite-0.4.4 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xcomposite-base-root && \
	make DESTDIR=/build/libx11-xcomposite-base-root install-strip && \
	post-root /build/libx11-xcomposite-base-root && \
	cd /build/libx11-xcomposite-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xcomposite-base-root /build/libx11-xcomposite-root && \
	cd /build/libx11-xcomposite-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xcomposite-deb \
		/build/libx11-xcomposite-root \
		/control/libx11-xcomposite/libx11-xcomposite \
		/packages/libx11-xcomposite_0.4.4-1_amd64.deb && \

	cp -a /build/libx11-xcomposite-base-root /build/libx11-xcomposite-devel-root && \
	cd /build/libx11-xcomposite-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xcomposite-devel-deb \
		/build/libx11-xcomposite-devel-root \
		/control/libx11-xcomposite/libx11-xcomposite-devel \
		/packages/libx11-xcomposite-devel_0.4.4-1_amd64.deb && \

	opkg install \
		/packages/libx11-xcomposite_*.deb /packages/libx11-xcomposite-devel_*.deb

# libXrender
ADD control/libx11-xrender /control/libx11-xrender
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXrender-0.9.10 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xrender-base-root && \
	make DESTDIR=/build/libx11-xrender-base-root install-strip && \
	post-root /build/libx11-xrender-base-root && \
	cd /build/libx11-xrender-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xrender-base-root /build/libx11-xrender-root && \
	cd /build/libx11-xrender-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xrender-deb \
		/build/libx11-xrender-root \
		/control/libx11-xrender/libx11-xrender \
		/packages/libx11-xrender_0.9.10-1_amd64.deb && \

	cp -a /build/libx11-xrender-base-root /build/libx11-xrender-devel-root && \
	cd /build/libx11-xrender-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xrender-devel-deb \
		/build/libx11-xrender-devel-root \
		/control/libx11-xrender/libx11-xrender-devel \
		/packages/libx11-xrender-devel_0.9.10-1_amd64.deb && \

	opkg install \
		/packages/libx11-xrender_*.deb /packages/libx11-xrender-devel_*.deb

# libXcursor
ADD control/libx11-xcursor /control/libx11-xcursor
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXcursor-1.1.14 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xcursor-base-root && \
	make DESTDIR=/build/libx11-xcursor-base-root install-strip && \
	post-root /build/libx11-xcursor-base-root && \
	cd /build/libx11-xcursor-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xcursor-base-root /build/libx11-xcursor-root && \
	cd /build/libx11-xcursor-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xcursor-deb \
		/build/libx11-xcursor-root \
		/control/libx11-xcursor/libx11-xcursor \
		/packages/libx11-xcursor_1.1.14-1_amd64.deb && \

	cp -a /build/libx11-xcursor-base-root /build/libx11-xcursor-devel-root && \
	cd /build/libx11-xcursor-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xcursor-devel-deb \
		/build/libx11-xcursor-devel-root \
		/control/libx11-xcursor/libx11-xcursor-devel \
		/packages/libx11-xcursor-devel_1.1.14-1_amd64.deb && \

	opkg install \
		/packages/libx11-xcursor_*.deb /packages/libx11-xcursor-devel_*.deb

# libXdamage
ADD control/libx11-xdamage /control/libx11-xdamage
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXdamage-1.1.4 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xdamage-base-root && \
	make DESTDIR=/build/libx11-xdamage-base-root install-strip && \
	post-root /build/libx11-xdamage-base-root && \
	cd /build/libx11-xdamage-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xdamage-base-root /build/libx11-xdamage-root && \
	cd /build/libx11-xdamage-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xdamage-deb \
		/build/libx11-xdamage-root \
		/control/libx11-xdamage/libx11-xdamage \
		/packages/libx11-xdamage_1.1.4-1_amd64.deb && \

	cp -a /build/libx11-xdamage-base-root /build/libx11-xdamage-devel-root && \
	cd /build/libx11-xdamage-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xdamage-devel-deb \
		/build/libx11-xdamage-devel-root \
		/control/libx11-xdamage/libx11-xdamage-devel \
		/packages/libx11-xdamage-devel_1.1.4-1_amd64.deb && \

	opkg install \
		/packages/libx11-xdamage_*.deb /packages/libx11-xdamage-devel_*.deb

# libfontenc
ADD control/libx11-fontenc /control/libx11-fontenc
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libfontenc-1.1.3 && \
	./configure $XORG_CONFIG && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-fontenc-base-root && \
	make DESTDIR=/build/libx11-fontenc-base-root install-strip && \
	post-root /build/libx11-fontenc-base-root && \
	cd /build/libx11-fontenc-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-fontenc-base-root /build/libx11-fontenc-root && \
	cd /build/libx11-fontenc-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-fontenc-deb \
		/build/libx11-fontenc-root \
		/control/libx11-fontenc/libx11-fontenc \
		/packages/libx11-fontenc_1.1.3-1_amd64.deb && \

	cp -a /build/libx11-fontenc-base-root /build/libx11-fontenc-devel-root && \
	cd /build/libx11-fontenc-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-fontenc-devel-deb \
		/build/libx11-fontenc-devel-root \
		/control/libx11-fontenc/libx11-fontenc-devel \
		/packages/libx11-fontenc-devel_1.1.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-fontenc_*.deb /packages/libx11-fontenc-devel_*.deb

# libXfont
ADD control/libx11-xfont /control/libx11-xfont
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXfont-1.5.2 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xfont-base-root && \
	make DESTDIR=/build/libx11-xfont-base-root install-strip && \
	post-root /build/libx11-xfont-base-root && \
	cd /build/libx11-xfont-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xfont-base-root /build/libx11-xfont-root && \
	cd /build/libx11-xfont-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xfont-deb \
		/build/libx11-xfont-root \
		/control/libx11-xfont/libx11-xfont \
		/packages/libx11-xfont_1.5.2-1_amd64.deb && \

	cp -a /build/libx11-xfont-base-root /build/libx11-xfont-devel-root && \
	cd /build/libx11-xfont-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xfont-devel-deb \
		/build/libx11-xfont-devel-root \
		/control/libx11-xfont/libx11-xfont-devel \
		/packages/libx11-xfont-devel_1.5.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-xfont_*.deb /packages/libx11-xfont-devel_*.deb

# libXft
ADD control/libx11-xft /control/libx11-xft
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXft-2.3.2 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xft-base-root && \
	make DESTDIR=/build/libx11-xft-base-root install-strip && \
	post-root /build/libx11-xft-base-root && \
	cd /build/libx11-xft-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xft-base-root /build/libx11-xft-root && \
	cd /build/libx11-xft-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xft-deb \
		/build/libx11-xft-root \
		/control/libx11-xft/libx11-xft \
		/packages/libx11-xft_2.3.2-1_amd64.deb && \

	cp -a /build/libx11-xft-base-root /build/libx11-xft-devel-root && \
	cd /build/libx11-xft-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xft-devel-deb \
		/build/libx11-xft-devel-root \
		/control/libx11-xft/libx11-xft-devel \
		/packages/libx11-xft-devel_2.3.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-xft_*.deb /packages/libx11-xft-devel_*.deb

# libXi
ADD control/libx11-xi /control/libx11-xi
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXi-1.7.8 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xi-base-root && \
	make DESTDIR=/build/libx11-xi-base-root install-strip && \
	post-root /build/libx11-xi-base-root && \
	cd /build/libx11-xi-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xi-base-root /build/libx11-xi-root && \
	cd /build/libx11-xi-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xi-deb \
		/build/libx11-xi-root \
		/control/libx11-xi/libx11-xi \
		/packages/libx11-xi_1.7.8-1_amd64.deb && \

	cp -a /build/libx11-xi-base-root /build/libx11-xi-devel-root && \
	cd /build/libx11-xi-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xi-devel-deb \
		/build/libx11-xi-devel-root \
		/control/libx11-xi/libx11-xi-devel \
		/packages/libx11-xi-devel_1.7.8-1_amd64.deb && \

	opkg install \
		/packages/libx11-xi_*.deb /packages/libx11-xi-devel_*.deb

# libXinerama
ADD control/libx11-xinerama /control/libx11-xinerama
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXinerama-1.1.3 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xinerama-base-root && \
	make DESTDIR=/build/libx11-xinerama-base-root install-strip && \
	post-root /build/libx11-xinerama-base-root && \
	cd /build/libx11-xinerama-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xinerama-base-root /build/libx11-xinerama-root && \
	cd /build/libx11-xinerama-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xinerama-deb \
		/build/libx11-xinerama-root \
		/control/libx11-xinerama/libx11-xinerama \
		/packages/libx11-xinerama_1.1.3-1_amd64.deb && \

	cp -a /build/libx11-xinerama-base-root /build/libx11-xinerama-devel-root && \
	cd /build/libx11-xinerama-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xinerama-devel-deb \
		/build/libx11-xinerama-devel-root \
		/control/libx11-xinerama/libx11-xinerama-devel \
		/packages/libx11-xinerama-devel_1.1.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-xinerama_*.deb /packages/libx11-xinerama-devel_*.deb

# libXrandr
ADD control/libx11-xrandr /control/libx11-xrandr
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXrandr-1.5.1 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xrandr-base-root && \
	make DESTDIR=/build/libx11-xrandr-base-root install-strip && \
	post-root /build/libx11-xrandr-base-root && \
	cd /build/libx11-xrandr-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xrandr-base-root /build/libx11-xrandr-root && \
	cd /build/libx11-xrandr-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xrandr-deb \
		/build/libx11-xrandr-root \
		/control/libx11-xrandr/libx11-xrandr \
		/packages/libx11-xrandr_1.5.1-1_amd64.deb && \

	cp -a /build/libx11-xrandr-base-root /build/libx11-xrandr-devel-root && \
	cd /build/libx11-xrandr-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xrandr-devel-deb \
		/build/libx11-xrandr-devel-root \
		/control/libx11-xrandr/libx11-xrandr-devel \
		/packages/libx11-xrandr-devel_1.5.1-1_amd64.deb && \

	opkg install \
		/packages/libx11-xrandr_*.deb /packages/libx11-xrandr-devel_*.deb

# libXres
ADD control/libx11-xres /control/libx11-xres
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXres-1.0.7 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xres-base-root && \
	make DESTDIR=/build/libx11-xres-base-root install-strip && \
	post-root /build/libx11-xres-base-root && \
	cd /build/libx11-xres-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xres-base-root /build/libx11-xres-root && \
	cd /build/libx11-xres-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xres-deb \
		/build/libx11-xres-root \
		/control/libx11-xres/libx11-xres \
		/packages/libx11-xres_1.0.7-1_amd64.deb && \

	cp -a /build/libx11-xres-base-root /build/libx11-xres-devel-root && \
	cd /build/libx11-xres-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xres-devel-deb \
		/build/libx11-xres-devel-root \
		/control/libx11-xres/libx11-xres-devel \
		/packages/libx11-xres-devel_1.0.7-1_amd64.deb && \

	opkg install \
		/packages/libx11-xres_*.deb /packages/libx11-xres-devel_*.deb

# libXtst
ADD control/libx11-xtst /control/libx11-xtst
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXtst-1.2.3 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xtst-base-root && \
	make DESTDIR=/build/libx11-xtst-base-root install-strip && \
	post-root /build/libx11-xtst-base-root && \
	cd /build/libx11-xtst-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xtst-base-root /build/libx11-xtst-root && \
	cd /build/libx11-xtst-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xtst-deb \
		/build/libx11-xtst-root \
		/control/libx11-xtst/libx11-xtst \
		/packages/libx11-xtst_1.2.3-1_amd64.deb && \

	cp -a /build/libx11-xtst-base-root /build/libx11-xtst-devel-root && \
	cd /build/libx11-xtst-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xtst-devel-deb \
		/build/libx11-xtst-devel-root \
		/control/libx11-xtst/libx11-xtst-devel \
		/packages/libx11-xtst-devel_1.2.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-xtst_*.deb /packages/libx11-xtst-devel_*.deb

# libXv
ADD control/libx11-xv /control/libx11-xv
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXv-1.0.11 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xv-base-root && \
	make DESTDIR=/build/libx11-xv-base-root install-strip && \
	post-root /build/libx11-xv-base-root && \
	cd /build/libx11-xv-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xv-base-root /build/libx11-xv-root && \
	cd /build/libx11-xv-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xv-deb \
		/build/libx11-xv-root \
		/control/libx11-xv/libx11-xv \
		/packages/libx11-xv_1.0.11-1_amd64.deb && \

	cp -a /build/libx11-xv-base-root /build/libx11-xv-devel-root && \
	cd /build/libx11-xv-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xv-devel-deb \
		/build/libx11-xv-devel-root \
		/control/libx11-xv/libx11-xv-devel \
		/packages/libx11-xv-devel_1.0.11-1_amd64.deb && \

	opkg install \
		/packages/libx11-xv_*.deb /packages/libx11-xv-devel_*.deb

# libXvMC
ADD control/libx11-xvmc /control/libx11-xvmc
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXvMC-1.0.10 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xvmc-base-root && \
	make DESTDIR=/build/libx11-xvmc-base-root install-strip && \
	post-root /build/libx11-xvmc-base-root && \
	cd /build/libx11-xvmc-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xvmc-base-root /build/libx11-xvmc-root && \
	cd /build/libx11-xvmc-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xvmc-deb \
		/build/libx11-xvmc-root \
		/control/libx11-xvmc/libx11-xvmc \
		/packages/libx11-xvmc_1.0.10-1_amd64.deb && \

	cp -a /build/libx11-xvmc-base-root /build/libx11-xvmc-devel-root && \
	cd /build/libx11-xvmc-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xvmc-devel-deb \
		/build/libx11-xvmc-devel-root \
		/control/libx11-xvmc/libx11-xvmc-devel \
		/packages/libx11-xvmc-devel_1.0.10-1_amd64.deb && \

	opkg install \
		/packages/libx11-xvmc_*.deb /packages/libx11-xvmc-devel_*.deb

# libXxf86dga
ADD control/libx11-xxf86dga /control/libx11-xxf86dga
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXxf86dga-1.1.4 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xxf86dga-base-root && \
	make DESTDIR=/build/libx11-xxf86dga-base-root install-strip && \
	post-root /build/libx11-xxf86dga-base-root && \
	cd /build/libx11-xxf86dga-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xxf86dga-base-root /build/libx11-xxf86dga-root && \
	cd /build/libx11-xxf86dga-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xxf86dga-deb \
		/build/libx11-xxf86dga-root \
		/control/libx11-xxf86dga/libx11-xxf86dga \
		/packages/libx11-xxf86dga_1.1.4-1_amd64.deb && \

	cp -a /build/libx11-xxf86dga-base-root /build/libx11-xxf86dga-devel-root && \
	cd /build/libx11-xxf86dga-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xxf86dga-devel-deb \
		/build/libx11-xxf86dga-devel-root \
		/control/libx11-xxf86dga/libx11-xxf86dga-devel \
		/packages/libx11-xxf86dga-devel_1.1.4-1_amd64.deb && \

	opkg install \
		/packages/libx11-xxf86dga_*.deb /packages/libx11-xxf86dga-devel_*.deb

# libXxf86vm
ADD control/libx11-xxf86vm /control/libx11-xxf86vm
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libXxf86vm-1.1.4 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xxf86vm-base-root && \
	make DESTDIR=/build/libx11-xxf86vm-base-root install-strip && \
	post-root /build/libx11-xxf86vm-base-root && \
	cd /build/libx11-xxf86vm-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xxf86vm-base-root /build/libx11-xxf86vm-root && \
	cd /build/libx11-xxf86vm-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xxf86vm-deb \
		/build/libx11-xxf86vm-root \
		/control/libx11-xxf86vm/libx11-xxf86vm \
		/packages/libx11-xxf86vm_1.1.4-1_amd64.deb && \

	cp -a /build/libx11-xxf86vm-base-root /build/libx11-xxf86vm-devel-root && \
	cd /build/libx11-xxf86vm-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xxf86vm-devel-deb \
		/build/libx11-xxf86vm-devel-root \
		/control/libx11-xxf86vm/libx11-xxf86vm-devel \
		/packages/libx11-xxf86vm-devel_1.1.4-1_amd64.deb && \

	opkg install \
		/packages/libx11-xxf86vm_*.deb /packages/libx11-xxf86vm-devel_*.deb

# libdmx
ADD control/libx11-dmx /control/libx11-dmx
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libdmx-1.1.3 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-dmx-base-root && \
	make DESTDIR=/build/libx11-dmx-base-root install-strip && \
	post-root /build/libx11-dmx-base-root && \
	cd /build/libx11-dmx-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-dmx-base-root /build/libx11-dmx-root && \
	cd /build/libx11-dmx-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-dmx-deb \
		/build/libx11-dmx-root \
		/control/libx11-dmx/libx11-dmx \
		/packages/libx11-dmx_1.1.3-1_amd64.deb && \

	cp -a /build/libx11-dmx-base-root /build/libx11-dmx-devel-root && \
	cd /build/libx11-dmx-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-dmx-devel-deb \
		/build/libx11-dmx-devel-root \
		/control/libx11-dmx/libx11-dmx-devel \
		/packages/libx11-dmx-devel_1.1.3-1_amd64.deb && \

	opkg install \
		/packages/libx11-dmx_*.deb /packages/libx11-dmx-devel_*.deb

# libpciaccess
ADD control/libpciaccess /control/libpciaccess
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libpciaccess-0.13.4 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libpciaccess-base-root && \
	make DESTDIR=/build/libpciaccess-base-root install-strip && \
	post-root /build/libpciaccess-base-root && \
	cd /build/libpciaccess-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libpciaccess-base-root /build/libpciaccess-root && \
	cd /build/libpciaccess-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libpciaccess-deb \
		/build/libpciaccess-root \
		/control/libpciaccess/libpciaccess \
		/packages/libpciaccess_0.13.4-1_amd64.deb && \

	cp -a /build/libpciaccess-base-root /build/libpciaccess-devel-root && \
	cd /build/libpciaccess-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libpciaccess-devel-deb \
		/build/libpciaccess-devel-root \
		/control/libpciaccess/libpciaccess-devel \
		/packages/libpciaccess-devel_0.13.4-1_amd64.deb && \

	opkg install \
		/packages/libpciaccess_*.deb /packages/libpciaccess-devel_*.deb

# libxkbfile
ADD control/libx11-xkbfile /control/libx11-xkbfile
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libxkbfile-1.0.9 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xkbfile-base-root && \
	make DESTDIR=/build/libx11-xkbfile-base-root install-strip && \
	post-root /build/libx11-xkbfile-base-root && \
	cd /build/libx11-xkbfile-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xkbfile-base-root /build/libx11-xkbfile-root && \
	cd /build/libx11-xkbfile-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xkbfile-deb \
		/build/libx11-xkbfile-root \
		/control/libx11-xkbfile/libx11-xkbfile \
		/packages/libx11-xkbfile_1.0.9-1_amd64.deb && \

	cp -a /build/libx11-xkbfile-base-root /build/libx11-xkbfile-devel-root && \
	cd /build/libx11-xkbfile-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xkbfile-devel-deb \
		/build/libx11-xkbfile-devel-root \
		/control/libx11-xkbfile/libx11-xkbfile-devel \
		/packages/libx11-xkbfile-devel_1.0.9-1_amd64.deb && \

	opkg install \
		/packages/libx11-xkbfile_*.deb /packages/libx11-xkbfile-devel_*.deb

# libxshmfence
ADD control/libx11-xshmfence /control/libx11-xshmfence
RUN \
	set +x && \
	XORG_PREFIX=/usr && \
	XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc" && \
	XORG_CONFIG="${XORG_CONFIG} --localstatedir=/var" && \
	XORG_CONFIG="${XORG_CONFIG} --disable-static " && \
	XORG_CONFIG="${XORG_CONFIG} --build=$(gcc -dumpmachine)" && \
	export XORG_PREFIX XORG_CONFIG && \
	cd /build && \
	cd libxshmfence-1.2 && \
	./configure $XORG_CONFIG --disable-devel-docs && \
	MAKE="make -j4" make && \
	pre-root /build/libx11-xshmfence-base-root && \
	make DESTDIR=/build/libx11-xshmfence-base-root install-strip && \
	post-root /build/libx11-xshmfence-base-root && \
	cd /build/libx11-xshmfence-base-root && \
	rm -rf usr/share && \
	
	cp -a /build/libx11-xshmfence-base-root /build/libx11-xshmfence-root && \
	cd /build/libx11-xshmfence-root && \
	rm -rf usr/lib/pkgconfig usr/include && \
	rm -f usr/lib/*.la && \
	make-deb \
		/build/libx11-xshmfence-deb \
		/build/libx11-xshmfence-root \
		/control/libx11-xshmfence/libx11-xshmfence \
		/packages/libx11-xshmfence_1.2-1_amd64.deb && \

	cp -a /build/libx11-xshmfence-base-root /build/libx11-xshmfence-devel-root && \
	cd /build/libx11-xshmfence-devel-root && \
	rm -f usr/lib/*.so* && \
	make-deb \
		/build/libx11-xshmfence-devel-deb \
		/build/libx11-xshmfence-devel-root \
		/control/libx11-xshmfence/libx11-xshmfence-devel \
		/packages/libx11-xshmfence-devel_1.2-1_amd64.deb && \

	opkg install \
		/packages/libx11-xshmfence_*.deb /packages/libx11-xshmfence-devel_*.deb

# libx11-all
ADD control/libx11-all /control/libx11-all
RUN \
	set +x && \
	mkdir -p /build/libx11-all-root /build/libx11-all-devel-root && \
	make-deb \
		/build/libx11-all-deb \
		/build/libx11-all-root \
		/control/libx11-all/libx11-all \
		/packages/libx11-all_7.7-1_all.deb && \
	make-deb \
		/build/libx11-all-devel-deb \
		/build/libx11-all-devel-root \
		/control/libx11-all/libx11-all-devel \
		/packages/libx11-all-devel_7.7-1_all.deb && \

	opkg install \
		/packages/libx11-all_*.deb /packages/libx11-all-devel_*.deb
