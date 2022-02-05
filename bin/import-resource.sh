#!/bin/sh

terraform state show $1 > /dev/null 2>&1

if [[ $(echo $?) -gt 0 ]]
  then terraform import $1 $2
fi
