FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg upgrade && \
	opkg install gcc make file pkg-config libc-devel libz-devel \
		libssl-devel libxml2-devel perl python27 python27-devel libreadline-devel && \
	opkg clean && \
	wget -O /download/postgresql-9.5.2.tar.bz2 \
		http://ftp.postgresql.org/pub/source/v9.5.2/postgresql-9.5.2.tar.bz2 && \
	cd /build && \
	tar xf /download/postgresql-9.5.2.tar.bz2 && \
	cd postgresql-9.5.2 && \
	./configure \
		--prefix=/usr --enable-thread-safety \
		--docdir=/usr/share/doc/postgresql-9.5.2 \
		--build=$(gcc -dumpmachine) \
		--with-perl --with-python --with-openssl --with-libxml && \
	MAKE="make -j4" make && \
	pre-root /build/postgresql-orig-root && \
	make DESTDIR=/build/postgresql-orig-root install-strip && \
	post-root /build/postgresql-orig-root && \
	cd /build/postgresql-orig-root && \
	rm -f usr/lib/*.a

ADD control /control
RUN \
	cp -a /build/postgresql-orig-root /build/postgresql-server-root && \
	cd /build/postgresql-server-root && \
	rm -rf usr/include usr/lib/pkgconfig usr/lib/postgresql/pgxs && \
	for cmd in \
		initdb pg_controldata pg_ctl pg_resetxlog postgres postmaster \
		; do mv -f usr/bin/${cmd} usr/ ; done && \
	rm -rf usr/bin && \
	mkdir -p usr/bin && \
	for cmd in \
		initdb pg_controldata pg_ctl pg_resetxlog postgres postmaster \
		; do mv -f usr/${cmd} usr/bin/ ; done && \
	make-deb \
		/build/postgresql-server-deb \
		/build/postgresql-server-root \
		/control/postgresql-server \
		/packages/postgresql-server_9.5.2-0_amd64.deb && \

	cp -a /build/postgresql-orig-root /build/postgresql-client-root && \
	cd /build/postgresql-client-root && \
	rm -rf usr/share usr/lib usr/include && \
	for cmd in \
		initdb pg_controldata pg_ctl pg_resetxlog postgres postmaster \
		ecpg pg_config ; do rm -f usr/bin/${cmd} ; done && \
	make-deb \
		/build/postgresql-client-deb \
		/build/postgresql-client-root \
		/control/postgresql-client \
		/packages/postgresql-client_9.5.2-0_amd64.deb && \

	cp -a /build/postgresql-orig-root /build/libpq-root && \
	cd /build/libpq-root && \
	rm -rf usr/share usr/bin usr/include && \
	rm -rf usr/lib/postgresql usr/lib/pkgconfig && \
	rm -f usr/lib/libecpg* usr/lib/libpgtypes.* && \	
	make-deb \
		/build/libpq-deb \
		/build/libpq-root \
		/control/libpq \
		/packages/libpq_9.5.2-0_amd64.deb && \

	cp -a /build/postgresql-orig-root /build/libpgtypes-root && \
	cd /build/libpgtypes-root && \
	rm -rf usr/share usr/bin usr/include && \
	rm -rf usr/lib/postgresql usr/lib/pkgconfig && \
	rm -f usr/lib/libecpg* usr/lib/libpq.* && \	
	make-deb \
		/build/libpgtypes-deb \
		/build/libpgtypes-root \
		/control/libpgtypes \
		/packages/libpgtypes_9.5.2-0_amd64.deb && \

	cp -a /build/postgresql-orig-root /build/libecpg-root && \
	cd /build/libecpg-root && \
	rm -rf usr/share usr/bin usr/include && \
	rm -rf usr/lib/postgresql usr/lib/pkgconfig && \
	rm -f usr/lib/libp* && \	
	make-deb \
		/build/libecpg-deb \
		/build/libecpg-root \
		/control/libecpg \
		/packages/libecpg_9.5.2-0_amd64.deb && \

	cp -a /build/postgresql-orig-root /build/postgresql-devel-root && \
	cd /build/postgresql-devel-root && \
	mv -f usr/bin/ecpg usr/ecpg && \
	mv -f usr/bin/pg_config usr/pg_config && \
	rm -rf usr/share usr/bin && \
	mkdir -p usr/bin && \
	mv -f usr/ecpg usr/bin/ && \
	mv -f usr/pg_config usr/bin/ && \
	rm -f usr/lib/*.so* usr/lib/postgresql/*.so* && \
	make-deb \
		/build/postgresql-devel-deb \
		/build/postgresql-devel-root \
		/control/postgresql-devel \
		/packages/postgresql-devel_9.5.2-0_amd64.deb

