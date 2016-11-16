FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel python27-devel && \
	wget -O /download/simplejson-3.10.0.tar.gz \
		https://pypi.python.org/packages/40/ad/52c1f3a562df3b210e8f165e1aa243a178c454ead65476a39fa3ce1847b6/simplejson-3.10.0.tar.gz && \
	cd /build && \
	tar xf /download/simplejson-3.10.0.tar.gz && \
	cd simplejson-3.10.0 && \
	python setup.py build && \
	pre-root /build/python-simplejson-root && \
	python setup.py install --root=/build/python-simplejson-root --prefix=/usr && \
	post-root /build/python-simplejson-root && \
	cd /build/python-simplejson-root && \
	find . -name ".so" -exec strip --strip-debug "{}" \; && \
	make-deb \
		/build/python-simplejson-deb \
		/build/python-simplejson-root \
		/control/python-simplejson \
		/packages/python-simplejson_3.10.0-1_amd64.deb
