#!/bin/bash
rm -rf TEMP
mkdir TEMP
cd TEMP
#git clone --mirror git@github.com:HsantoshaKumara/test.git
#cd test.git
branch_commit_ID="$1"
#if ! git rev-parse --verify "$branch_commit_ID" >/dev/null 2>&1 
#if ! git ls-remote "$https://github.com/HsantoshaKumara/test.git" | grep -q "$branch_commit_ID"
#then echo "branch_commit_ID is not valid"
#exit 1

git clone --mirror https://github.com/HsantoshaKumara/test.git
cd test.git
branch_commit_ID="$1"
if ! git ls-remote "https://${SECRETS}@github.com/HsantoshaKumara/test.git" | grep -q "$branch_commit_ID"
 then
  echo "branch_commit_ID is not valid"
  exit 1
fi



