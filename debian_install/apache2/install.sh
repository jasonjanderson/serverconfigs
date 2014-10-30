#!/bin/bash

CURRENT_DIR=$(dirname $0)

sudo cat >> /etc/apt/sources.list << EOF

## LAMP Stable Updates ##
deb http://php53.dotdeb.org oldstable all
deb-src http://php53.dotdeb.org oldstable all
EOF

sudo wget http://www.dotdeb.org/dotdeb.gpg
sudo cat dotdeb.gpg | sudo apt-key add -
rm dotdeb.gpg

sudo apt-get install apache2 php5 libapache2-mod-php5
sudo apt-get update
sudo apt-get dist-upgrade

INSTALLED_MODULES=$(ls /etc/apache2/mods-enabled/ | perl -p -e "s/.conf//g" | perl -p -e "s/.load//g")

sudo userdel www-data
sudo useradd --home-dir /var/www --shell /bin/false --system apache

sudo cp -r /etc/apache2 /etc/apache2.default
sudo rm -rf /etc/apache2/*

sudo cp -r ${CURRENT_DIR}/conf/* /etc/apache2/
sudo cp -r /etc/apache2.default/mods-available/* /etc/apache2/mods-available/

for i in ${INSTALLED_MODULES}
do
  sudo a2enmod $i
done

sudo /etc/init.d/apache2 restart

exit 0
