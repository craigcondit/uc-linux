FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ENV JAVA_HOME /usr/lib/jvm/default-jre

RUN \
	opkg update && \
	opkg install openjdk-jre8 && \
	opkg clean
