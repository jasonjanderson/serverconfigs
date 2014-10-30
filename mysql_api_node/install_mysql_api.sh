#!/bin/sh

apt-get update
apt-get install mysql-server

if [ -d ./conf ]; then
  cp ./conf/* /etc/mysql/
fi

/etc/init.d/mysql restart

exit 0
