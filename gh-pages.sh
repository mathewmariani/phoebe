#!/bin/bash
set -e # Exit with nonzero exit code if anything fails

# set up some variables
SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"
GITHUB_REF="github.com/mathewmariani/phoebe.git"

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "master" ]; then
    echo "This commit was made against the $TRAVIS_BRANCH and not the master!"
    exit 0
fi

# change to Jekyll build directory
cd _site

git init
git config user.name "Mat Mariani"
git config user.email "someone.mariani@gmail.com"
git add .
git commit -m "Deployed to Github Pages - Travis-CI"

git push --force --quiet "https://${GITHUB_TOKEN}@${GITHUB_REF}" ${SOURCE_BRANCH}:${TARGET_BRANCH} > /dev/null 2>&1
