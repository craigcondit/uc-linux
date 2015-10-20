#!/bin/sh
set -e

set_listen_addresses() {
	sedEscapedValue="$(echo "$1" | sed 's/[\/&]/\\&/g')"
	sed -ri "s/^#?(listen_addresses\s*=\s*)\S+/\1'$sedEscapedValue'/" "$PGDATA/postgresql.conf"
}

export FOO=bar

if [ "$1" = 'postgres' ]; then
	mkdir -p "${PGDATA}"
	chown -R postgres "${PGDATA}"

	mkdir -p /run/postgresql
	chmod g+s /run/postgresql
	chown -R postgres /run/postgresql

	firstrun=NO

	if [ ! -s "${PGDATA}/PG_VERSION" ]; then
		runas postgres initdb
		echo "local all postgres ident" > "${PGDATA}/pg_hba.conf"
		chown postgres "${PGDATA}/pg_hba.conf"	
		chmod 600 "${PGDATA}/pg_hba.conf"	
		cp -a "${PGDATA}/pg_hba.conf" "${PGDATA}/pg_hba.conf.template"
		cp -a "${PGDATA}/postgresql.conf" "${PGDATA}/postgresql.conf.template"
		firstrun=YES
	fi

	cp -a "${PGDATA}/pg_hba.conf.template" "${PGDATA}/pg_hba.conf"
	cp -a "${PGDATA}/postgresql.conf.template" "${PGDATA}/postgresql.conf"

	if [ "${POSTGRES_PASSWORD}" ]; then
		pass="PASSWORD '${POSTGRES_PASSWORD}'"
		authMethod=md5
	else
		cat >&2 <<-'ENOWARN'
			****************************************************
			WARNING: No password has been set for the database.
				This will allow anyone with access to the
				Postgres port to access your database. In
				Docker's default configuration, this is
				effectively any other container on the same
				system.
				Use "-e POSTGRES_PASSWORD=password" to set
				it in "docker run".
			****************************************************
		ENOWARN
		pass=
		authMethod=trust
	fi

	( echo; echo "local all all $authMethod"; ) >> "$PGDATA/pg_hba.conf"
	( echo; echo "host all all 0.0.0.0/0 $authMethod"; ) >> "$PGDATA/pg_hba.conf"
	
	runas postgres pg_ctl -D "${PGDATA}" -o "-c listen_addresses=''" -w start
	: ${POSTGRES_USER:=postgres}
	: ${POSTGRES_DB:=$POSTGRES_USER}

	if [ "${firstrun}" == "YES" ]; then
		if [ "${POSTGRES_DB}" != "postgres" ]; then
			runas postgres psql --username postgres <<-EOSQL
				CREATE DATABASE "${POSTGRES_DB}" ;
			EOSQL
			echo
		fi
	fi

	if [ "${firstrun}" == "YES" ]; then
		op='CREATE'
	else
		op='ALTER'
	fi

	if [ "${POSTGRES_USER}" = 'postgres' ]; then
		op='ALTER'
	fi
	
	runas postgres psql --username postgres <<-EOSQL
		$op USER "${POSTGRES_USER}" WITH SUPERUSER $pass ;
	EOSQL
	echo

	if [ "${firstrun}" == "YES" ]; then
		echo
		for f in /docker-entrypoint-initdb.d/* ; do
			case "$f" in
				*.sh)	echo "$0: running $f" ; . "$f" ;;
				*.sql) echo "$0: running $f" ; runas postgres psql --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" < "$f" && echo ;;
				*)		 echo "$0: ignoring $f" ;;
			esac
			echo
		done
	fi

	runas postgres pg_ctl -D "${PGDATA}" -m fast -w stop
	set_listen_addresses '*'

	echo
	echo 'PostgreSQL init process complete; ready for startup.'
	echo

	exec runas postgres "$@"
fi

exec "$@"
