#!/bin/sh
set -e

if [ "$1" = '/usr/share/zookeeper/bin/zkServer.sh' ]; then
	mkdir -p "${ZOOKEEPER_DATA_DIR}" "${ZOOKEEPER_LOG_DIR}"
	chown -R zookeeper:zookeeper "${ZOOKEEPER_DATA_DIR}" "${ZOOKEEPER_LOG_DIR}"
	sed -i "s@^dataDir=.*@dataDir=${ZOOKEEPER_DATA_DIR}@" /etc/zookeeper/zoo.cfg
	sed -i "s@.*ZOO_LOG_DIR.*@@" /etc/zookeeper/zookeeper-env.sh
	echo "ZOO_LOG_DIR=\"${ZOOKEEPER_LOG_DIR}\"" >> /etc/zookeeper/zookeeper-env.sh

	firstrun=NO

	if [ ! -d "${ZOOKEEPER_DATA_DIR}/version-2" ]; then
		firstrun=YES
	fi

	if [ "${firstrun}" == "YES" ]; then
		echo

		echo "Starting ZooKeeper in local mode for initial configuration..."
		cp -a /etc/zookeeper/zoo.cfg /tmp/zoo.cfg
		sed -i 's/.*clientPortAddress//' /tmp/zoo.cfg
		echo "clientPortAddress=127.0.0.01" >> /tmp/zoo.cfg
		runas zookeeper /usr/share/zookeeper/bin/zkServer.sh start /tmp/zoo.cfg
		echo "Zookeeper started in local mode..."
		echo

		echo "Running init.d scripts..."
		for f in /docker-entrypoint-init.d/* ; do
			case "$f" in
				*.sh)  echo "$0: running $f" ; . "$f" ;;
				*)     echo "$0: ignoring $f" ;;
			esac
			echo
		done

		echo "Stopping Zookeeper.."
		runas zookeeper /usr/share/zookeeper/bin/zkServer.sh stop /tmp/zoo.cfg
		rm -f /tmp/zoo.cfg

		echo "Zookeeper configured and ready for use."
	fi
fi

exec runas zookeeper "$@"
