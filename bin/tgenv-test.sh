#!/bin/sh

if [[ $(which tgenv > /dev/null; echo $?) -gt 0 ]]
  then echo -e '\n[ERROR] "tgenv" not found, you need to have tgenv installed to use terragrunt\n' && exit 1
fi
