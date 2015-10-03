FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ENV JAVA_HOME /usr/lib/java/jdk1.8.0_60

RUN \
	opkg update && \
	opkg install oracle-server-jre-8 && \
	opkg clean
