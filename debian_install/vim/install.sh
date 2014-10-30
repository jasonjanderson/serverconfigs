#!/bin/bash

CURRENT_DIR=$(dirname $0)

cat ${CURRENT_DIR}/vimrc > ~/.vimrc

mkdir ~/.vim/

cp -R ${CURRENT_DIR}/dotvim/* ~/.vim/

exit 0
