#!/bin/sh
set -e

export LOG_DIR="${KAFKA_LOG_DIR}"

if [ -z "${KAFKA_ADVERTISED_HOST}" ]; then
	export KAFKA_ADVERTISED_HOST="$(hostname -i)"
fi

if [ "$1" = '/usr/share/kafka/bin/kafka-server-start.sh' ]; then
	if [ -z "${ZOOKEEPER_PORT}" ]; then
		echo "Please link a Docker zookeeper container with this one under the name ZOOKEEPER." >&2
		exit 1
	fi

	ZOOKEEPER_HOST=$(echo "${ZOOKEEPER_PORT}" | sed 's@.*//@@' | sed 's/:.*//')
	ZOOKEEPER_PORT=$(echo "${ZOOKEEPER_PORT}" | sed 's@.*:@@')

	mkdir -p "${KAFKA_DATA_DIR}" "${KAFKA_LOG_DIR}"
	chown -R kafka:kafka "${KAFKA_DATA_DIR}" "${KAFKA_LOG_DIR}"

	sed -i 's/host.name.*//' /etc/kafka/server.properties
	sed -i 's/advertised.host.name=.*//' /etc/kafka/server.properties
	sed -i 's/advertised.port=.*//' /etc/kafka/server.properties
	sed -i 's/log.dirs=.*//' /etc/kafka/server.properties
	sed -i 's/.*zookeeper.connect=.*//' /etc/kafka/server.properties
	echo "host.name=0.0.0.0" >> /etc/kafka/server.properties
	echo "advertised.host.name=${KAFKA_ADVERTISED_HOST}" >> /etc/kafka/server.properties
	echo "advertised.port=${KAFKA_ADVERTISED_PORT}" >> /etc/kafka/server.properties
	echo "log.dirs=${KAFKA_DATA_DIR}" >> /etc/kafka/server.properties
	echo "zookeeper.connect=${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT}${KAFKA_ZK_CHROOT}" >> /etc/kafka/server.properties

	sed -i 's/.*zookeeper.connect=.*//' /etc/kafka/consumer.properties
	echo "zookeeper.connect=${ZOOKEEPER_HOST}:${ZOOKEEPER_PORT}${KAFKA_ZK_CHROOT}" >> /etc/kafka/consumer.properties

	rm -f /usr/share/kafka/logs
	ln -sf "${KAFKA_LOG_DIR}" /usr/share/kafka/logs
fi

exec runas kafka "$@"
