#!/bin/bash
set -e

if [ -z "$MYSQL_NAME" ]; then
	echo "Missing linked mysql container"
	exit 1
fi

cat >/etc/dbconfig-common/phpmyadmin.conf <<EOF
dbc_install='true'
dbc_upgrade='true'
dbc_remove='true'
dbc_dbtype='mysql'
dbc_dbuser='root'
dbc_dbpass='${MYSQL_ENV_MYSQL_ROOT_PASSWORD}'
dbc_dbserver='${MYSQL_PORT_3306_TCP_ADDR}'
dbc_dbport='${MYSQL_PORT_3306_TCP_PORT}'
dbc_dbname=''
dbc_dbadmin='root'
dbc_basepath=''
dbc_ssl=''
dbc_authmethod_admin=''
dbc_authmethod_user=''
EOF


dpkg-reconfigure phpmyadmin


exec "$@"
