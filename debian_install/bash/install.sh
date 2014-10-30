#!/bin/bash
CURRENT_DIR=$(dirname $0)

apt-get install bash-completion

cp ${CURRENT_DIR}/bashrc ~/.bashrc
cp ${CURRENT_DIR}/bash_scripts ~/.bash_scripts
cp ${CURRENT_DIR}/bash_motd ~/.bash_motd
cp ${CURRENT_DIR}/bash_aliases ~/.bash_aliases

exit 0
