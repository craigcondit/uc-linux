FROM insideo/jre8
MAINTAINER ccondit@randomcoder.com

RUN \
	opkg update && \
	opkg install kafka runas && \
	opkg clean && \
	addgroup -S -g 103 kafka && \
	mkdir -p /var/lib/kafka && \
	adduser -h /var/lib/kafka -g "Kafka user" -s /bin/sh -G kafka -S -D -u 103 kafka && \
	chown -R kafka:kafka /var/lib/kafka && \
	echo "delete.topic.enable=true" >> /etc/kafka/server.properties

COPY docker-entrypoint.sh /

ENV KAFKA_DATA_DIR=/data KAFKA_LOG_DIR=/logs KAFKA_HEAP_OPTS=-Xmx256m KAFKA_ADVERTISED_HOST= KAFKA_ADVERTISED_PORT=9092 KAFKA_ZK_CHROOT=

VOLUME [ '/data', '/logs' ]

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 9092

CMD [ "/usr/share/kafka/bin/kafka-server-start.sh", "/etc/kafka/server.properties" ]
