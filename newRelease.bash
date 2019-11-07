#!/bin/bash
set -e
GIT_URL='git@github.com:serg-bs/new-release.git'
OLD_BRANCH='rel/1.1'
NEW_BRANCH='rel/1.2'

eval repository_dir=`expr match "$GIT_URL" '.*/\(.*.git\)$'`

if [ ! -d $repository_dir ]; then
    git clone --bare $GIT_URL
fi
cd $repository_dir
git remote -v
git fetch origin +refs/heads/*:refs/heads/* --prune
if [ `git branch --list $NEW_BRANCH` ]
then
    echo "Branch named $NEW_BRANCH already exists" >&2
else
    git update-ref refs/heads/$NEW_BRANCH refs/heads/$OLD_BRANCH
    git push origin $NEW_BRANCH
fi