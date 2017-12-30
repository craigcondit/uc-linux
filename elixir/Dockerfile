FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install locale-utils locale-data && \
	echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
	locale-gen && \
	opkg remove locale-data && \
	export LC_ALL=en_US.UTF-8 && \
	opkg install make erlang git && \
	wget -O /download/elixir-1.5.3.tar.gz \
		https://github.com/elixir-lang/elixir/archive/v1.5.3.tar.gz && \
	cd /build && \
	tar xf /download/elixir-1.5.3.tar.gz && \
	cd elixir-1.5.3 && \
	MAKE="make -j4" make PREFIX=/usr && \
	pre-root /build/elixir-root && \
	make DESTDIR=/build/elixir-root PREFIX=/usr install && \
	post-root /build/elixir-root && \
	cd /build/elixir-root && \
	rm -rf usr/share && \
	cd /build && \
	make-deb \
		/build/elixir-deb \
		/build/elixir-root \
		/control/elixir \
		/packages/elixir-1.5.3-1_amd64.deb
