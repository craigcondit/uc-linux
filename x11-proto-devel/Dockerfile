FROM insideo/uc-linux:hydrogen

MAINTAINER ccondit@randomcoder.com

ADD scripts /scripts
ADD control /control
RUN \
	set +x && \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel x11-util-macros && \
	export XORG_PREFIX=/usr && \
	export XORG_CONFIG="--prefix=$XORG_PREFIX --sysconfdir=/etc --localstatedir=/var --disable-static --build=$(gcc -dumpmachine)" && \
	for pkg in $(grep -v '^#' /scripts/manifest | awk '{print $2}'); do \
		wget -O /download/${pkg} http://ftp.x.org/pub/individual/proto/${pkg} ; done && \
	cd /download && \
	md5sum -c /scripts/manifest && \
	pre-root /build/x11-proto-devel-root && \
	cd /build && \
	for pkg in $(grep -v '^#' /scripts/manifest | awk '{print $2}'); do ( \
		pkgdir=${pkg%.tar.bz2} && \
		cd /build && \
		tar xf "/download/${pkg}" && \
		cd "/build/${pkgdir}" && \
		./configure $XORG_CONFIG && \
		make DESTDIR=/build/x11-proto-devel-root install-strip && \
		cd /build \
	) ; done && \
	post-root /build/x11-proto-devel-root && \
	cd /build/x11-proto-devel-root && \
	rm -rf usr/share && \
	make-deb \
		/build/x11-proto-devel-deb \
		/build/x11-proto-devel-root \
		/control/x11-proto-devel \
		/packages/x11-proto-devel_7.7-1_amd64.deb && \

	cd / && \
	rm -rf /build /control /download /scripts
