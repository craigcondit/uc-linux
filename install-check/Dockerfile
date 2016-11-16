FROM insideo/uc-linux:hydrogen
MAINTAINER ccondit@randomcoder.com

RUN \
	opkg update && \
	opkg install $(opkg list | awk '{print $1}')

RUN \
	opkg clean
