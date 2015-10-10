FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

RUN \
	opkg update && \
	opkg install openjdk-jre8 && \
	opkg clean
