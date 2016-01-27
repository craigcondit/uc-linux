FROM scratch
MAINTAINER ccondit@randomcoder.com
ADD stage3.tar.xz /

ENV PATH /usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin

RUN \
	opkg update && \
	opkg upgrade && \
	opkg install libcurl && \
	opkg remove libcurl-bootstrap && \
	opkg clean

CMD ["/bin/sh"]
