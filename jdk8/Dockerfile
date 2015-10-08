FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

ENV JAVA_HOME /usr/lib/jvm/default-jdk

RUN \
	opkg update && \
	opkg install openjdk-jdk8 && \
	opkg clean
