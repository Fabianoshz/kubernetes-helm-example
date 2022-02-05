#!/bin/sh

if [[ $(which tfenv > /dev/null; echo $?) -gt 0 ]]
  then echo -e '\n[ERROR] "tfenv" not found, you need to have tfenv installed to use terragrunt\n' && exit 1
fi
