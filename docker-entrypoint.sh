#!/bin/bash
set -e

if [ -n "$MYSQL_NAME" ]; then
	MYSQL_USER=root
	MYSQL_PASSWORD=${MYSQL_ENV_MYSQL_ROOT_PASSWORD}
	MYSQL_HOST_ADDR=${MYSQL_PORT_3306_TCP_ADDR}
	MYSQL_HOST_PORT=${MYSQL_PORT_3306_TCP_PORT}
fi

cat >/etc/dbconfig-common/phpmyadmin.conf <<EOF
dbc_install='true'
dbc_upgrade='true'
dbc_remove='true'
dbc_dbtype='mysql'
dbc_dbuser='${MYSQL_USER}'
dbc_dbpass='${MYSQL_PASSWORD}'
dbc_dbserver='${MYSQL_HOST_ADDR}'
dbc_dbport='${MYSQL_HOST_PORT}'
dbc_dbname=''
dbc_dbadmin='root'
dbc_basepath=''
dbc_ssl=''
dbc_authmethod_admin=''
dbc_authmethod_user=''
EOF


dpkg-reconfigure phpmyadmin


exec "$@"
