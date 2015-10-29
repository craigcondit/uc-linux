FROM insideo/uc-linux:buggy
MAINTAINER ccondit@randomcoder.com

RUN \
	opkg update && \
	opkg install rabbitmq-server && \
	opkg clean && \
	addgroup -S -g 101 rabbitmq && \
	mkdir -p /var/lib/rabbitmq && \
	adduser -h /var/lib/rabbitmq -g "RabbitMQ user" -s /bin/sh -G rabbitmq -S -D -u 101 rabbitmq && \
	chown -R rabbitmq:rabbitmq /var/lib/rabbitmq && \
	mkdir -p /etc/rabbitmq && \
	echo "NODENAME=rabbit@localhost" > /etc/rabbitmq/rabbitmq-env.conf && \
	echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config && \
	rabbitmq-plugins enable --offline rabbitmq_management && \
	mkdir -p /docker-entrypoint-init.d

COPY docker-entrypoint.sh /
	
ENV RABBITMQ_LOG_BASE=/data/log RABBITMQ_MNESIA_BASE=/data/mnesia

VOLUME [ "/data/log", "/data/mnesia" ]

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5672
EXPOSE 15672

CMD ["rabbitmq-server"]
