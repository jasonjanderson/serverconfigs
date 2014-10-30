#!/bin/bash

for i in $(ls -d */)
do
  ./${i}install.sh
done

exit 0
