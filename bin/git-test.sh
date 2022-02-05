#!/bin/sh

git fetch

commits=$(git log HEAD..origin/master --oneline | wc -l)

if [[ $commits -gt 0 ]]
  then echo -e "\n[ERROR] Your branch is behind 'origin/master' by ${commits} commits, you need to update your branch to use terragrunt\n" && exit 1
fi
