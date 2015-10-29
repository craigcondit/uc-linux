#!/bin/sh
set -e

if [ "$1" = 'rabbitmq-server' ]; then
	mkdir -p "${RABBITMQ_LOG_BASE}"
	chown -R rabbitmq:rabbitmq "${RABBITMQ_LOG_BASE}"

	mkdir -p "${RABBITMQ_MNESIA_BASE}"
	chown -R rabbitmq:rabbitmq "${RABBITMQ_MNESIA_BASE}"

	firstrun=NO

	if [ ! -d "${RABBITMQ_MNESIA_BASE}/rabbit@localhost" ]; then
		firstrun=YES
	fi

	if [ "${firstrun}" == "YES" ]; then
		echo

		echo "Starting RabbitMQ in local mode for initial configuration..."

		RABBITMQ_NODE_IP_ADDRESS=127.0.0.1 rabbitmq-server -detached 2>/dev/null
		STARTED=0
		set +e
		while [ ${STARTED} -ne 1 ]; do
			rabbitmqctl cluster_status >/dev/null 2>/dev/null
			RESULT=$?
			if [ ${RESULT} -eq 0 ]; then
				STARTED=1
			else
				sleep 1
			fi
		done
		set -e

		echo "RabbitMQ started in local mode..."

		for f in /docker-entrypoint-init.d/* ; do
			case "$f" in
				*.sh)  echo "$0: running $f" ; . "$f" ;;
				*)     echo "$0: ignoring $f" ;;
			esac
			echo
		done

		echo "Stopping RabbitMQ..."
		rabbitmqctl stop
		killall epmd || true
		sleep 5

		echo "RabbitMQ configured and ready for use."
	fi
fi

exec "$@"
