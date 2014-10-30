#!/bin/sh

apt-get update
apt-get install mysql-server

mkdir /var/lib/mysql-cluster
chown mysql:mysql /var/lib/mysql-cluster/

if [ -d ./conf ]; then
  cp ./conf/* /etc/mysql/
fi

/etc/init.d/mysql stop
update-rc.d -f mysql remove

/etc/init.d/mysql-ndb-mgm restart
update-rc.d mysql-ndb-mgm defaults

exit 0
