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
		echo

		echo "Creating internal administrative user..."
		ADMIN_PASSWORD="$(dd if=/dev/urandom bs=104 count=1 2>/dev/null | md5sum | awk '{print $1}')"
		cat > /root/.rabbitmqadmin.conf <<EOF
[default]
hostname = localhost
port = 15672
username = dockeradmin
password = ${ADMIN_PASSWORD}
declare_vhost = /
vhost = /
EOF
		chmod 400 /root/.rabbitmqadmin.conf
		rabbitmqctl add_user dockeradmin "${ADMIN_PASSWORD}"
		rabbitmqctl set_user_tags dockeradmin administrator
		rabbitmqctl set_permissions -p / dockeradmin ".*" ".*" ".*"

		echo "Setting cluster name..."
		rabbitmqctl set_cluster_name rabbit@docker

		echo "Removeing guest user..."
		rabbitmqctl delete_user guest
	
		echo "Setting up admin user (delete this in init.d if you don't want it)..."
		rabbitmqctl add_user admin admin
		rabbitmqctl set_user_tags admin administrator
		rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
	
		echo "Running init.d scripts..."
		for f in /docker-entrypoint-init.d/* ; do
			case "$f" in
				*.sh)  echo "$0: running $f" ; . "$f" ;;
				*)     echo "$0: ignoring $f" ;;
			esac
			echo
		done

		echo "Stopping RabbitMQ..."
		rabbitmqctl stop
		killall -9 epmd || true
		sleep 1

		echo "RabbitMQ configured and ready for use."
	fi
fi

export RABBITMQ_NODE_IP_ADDRESS=0.0.0.0
exec "$@"
