FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ADD control /control
RUN \
	mkdir -p /build /control /download /packages && \
	opkg update && \
	opkg install gcc make file linux-devel python27-devel && \
	wget -O /download/simplejson-3.8.1.tar.gz \
		https://pypi.python.org/packages/source/s/simplejson/simplejson-3.8.1.tar.gz && \
	cd /build && \
	tar xf /download/simplejson-3.8.1.tar.gz && \
	cd simplejson-3.8.1 && \
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
		/packages/python-simplejson_3.8.1-0_amd64.deb
