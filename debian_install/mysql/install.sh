#!/bin/sh

CURRENT_DIR=$(dirname $0)

SQL_USER="root"
SQL_PASSWORD="CF1kRyNjoD6.NaI"

sudo apt-get install mysql-server-5.0 php5-mysql

sudo mysql --user="${SQL_USER}" --password="${SQL_PASSWORD}" mysql < ${CURRENT_DIR}/secure_mysql.sql

exit 0
