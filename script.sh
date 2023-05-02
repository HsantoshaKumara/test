#!/bin/bash

# Clone the repository
rm -rf TEMP
mkdir TEMP
cd TEMP
GIT_TERMINAL_PROMPT=0 git clone https://${{ secrets.SECRET }}@github.com/HsantoshaKumara/test.git
cd test.git

# Get the branch or commit ID from user input
branch_commit_ID="$1"
if ! git rev-parse --verify "$branch_commit_ID" >/dev/null 2>&1; then
  echo "Invalid branch or commit ID: $branch_commit_ID"
  exit 1
fi

# Ask user if they want to rename the tag
ans="$2"
while [ "$ans" != "yes" ] && [ "$ans" != "no" ]; do 
  echo "Please answer with yes or no"
  read ans
done

# Rename the tag if requested by the user
if [ "$ans" == "yes" ]; then
  suffix=$(date +"%Y-%m-%d_%H.%M.%S")
  TEMP="PROD-$suffix"
  while git rev-parse --quiet --verify "refs/tags/$TEMP" >/dev/null; do 
    echo "Error: $TEMP already exists"
    exit 1
  done
  echo "Renaming tag to $TEMP"
  git checkout PROD
  git tag -f $TEMP PROD^{}
  git tag -d PROD
  git push origin $TEMP
  git checkout $branch_commit_ID
fi

# Checkout the branch or commit ID
cd ..
git clone https://${{ secrets.SECRET }}@github.com/HsantoshaKumara/test.git
cd test
git checkout $branch_commit_ID

# Create or update the PROD tag
if [ "$ans" == "yes" ]; then
  git checkout PROD
  git tag -d PROD
  git tag PROD -m "new tag"
  git push origin :refs/tags/PROD
  git push origin PROD
  echo "PROD tag updated"
else
  git tag -a PROD -m "new tag"
  git push origin PROD
  echo "PROD tag created"
fi

# Clean up
cd ../..
rm -rf TEMP




