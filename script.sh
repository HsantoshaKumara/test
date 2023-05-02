#!/bin/bash
rm -rf TEMP
mkdir TEMP
cd TEMP
#git clone --mirror git@github.com:HsantoshaKumara/test.git
#cd test.git
branch_commit_ID="$1"
#if ! git rev-parse --verify "$branch_commit_ID" >/dev/null 2>&1 
if ! git ls-remote "$https://github.com/HsantoshaKumara/test.git" | grep -q "$branch_commit_ID"
then echo "branch_commit_ID is not valid"
exit 1
fi
ans="$2"
while ["ans" != "yes" ] && ["ans" != "no" ]
do 
echo " please answer with yes or no "
read ans
done
if [ "ans" == "yes" ]
then
suffix=$(date +"%Y-%m-%d&%H.%m.%S")
TEMP="PROD-$suffix"
while git rev-parse --quite --verify "refs/tags/$TEMP" >/dev/null
do 
echo "Error $TEMP exits"
exit 1
done
echo ""tag name changing to $TEMP
else
echo "tag name name will not be changed"
fi
cd ..
git clone git@github.com:HsantoshaKumara/test.git
cd test
git checkout $branch_commit_ID
if [ "$ans" == "yes" ]
then
git checkout PROD
echo "renaming"
git tag -f $TEMP PROD^{}
echo "renamed"
echo "deleting"
git tag -d PROD
echo "deleted"
git push origin $TEMP
git checkout $branch_commit_ID
git clone git@github.com:HsantoshaKumara/test.git
git checkout $branch_commit_ID
fi
git tag -d PROD
git tag PROD -m "new tag "
git push origin :refs/tags/PROD
git push origin PROD
echo "PROD tag created"
cd../..
rm -rf TEMP
