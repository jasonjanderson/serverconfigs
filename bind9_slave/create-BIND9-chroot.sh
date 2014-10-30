#!/bin/bash

CHROOT_DIR="/var/lib/bind"

apt-get update
apt-get upgrade
apt-get install bind9 syslogd

/etc/init.d/bind9 stop
/etc/init.d/sysklogd stop

groupdel bind
userdel bind

mkdir -p "${CHROOT_DIR}"

adduser --system --no-create-home --group --disabled-password --disabled-login --shell /bin/false --home ${CHROOT_DIR} bind

cat <<EOF > /etc/default/bind9
OPTIONS="-u bind -t ${CHROOT_DIR}"
# Set RESOLVCONF=no to not run resolvconf
RESOLVCONF=yes
EOF

mkdir -p ${CHROOT_DIR}/etc
mkdir ${CHROOT_DIR}/dev
mkdir -p ${CHROOT_DIR}/var/cache/bind
mkdir -p ${CHROOT_DIR}/var/run/bind/run
mkdir -p ${CHROOT_DIR}/var/log/bind
mv /etc/bind ${CHROOT_DIR}/etc

ln -s ${CHROOT_DIR}/etc/bind /etc/bind

mknod ${CHROOT_DIR}/dev/null c 1 3
mknod ${CHROOT_DIR}/dev/random c 1 8
chmod 666 ${CHROOT_DIR}/dev/null ${CHROOT_DIR}/dev/random
chown -R bind:bind ${CHROOT_DIR}/var/*
chown -R bind:bind ${CHROOT_DIR}/etc/bind

cat <<EOF > /etc/default/syslogd
#
# Top configuration file for syslogd
#

#
# Full documentation of possible arguments are found in the manpage
# syslogd(8).
#

#
# For remote UDP logging use SYSLOGD="-r"
#
SYSLOGD="-a ${CHROOT_DIR}/dev/log"
EOF

if [ -d ./conf ]; then
  rm -rf ${CHROOT_DIR}/etc/bind/*
  cp -r ./conf/* ${CHROOT_DIR}/etc/bind/
  chown -R bind:bind ${CHROOT_DIR}/etc/bind
fi

/etc/init.d/sysklogd start
/etc/init.d/bind9 start

exit 0

