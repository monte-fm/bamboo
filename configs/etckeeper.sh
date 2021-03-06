#!/bin/bash

export LC_ALL=C
sudo apt-get install etckeeper -y

echo "
VCS="git"

#VCS="hg"
#VCS="bzr"
#VCS="darcs"

GIT_COMMIT_OPTIONS=""
HG_COMMIT_OPTIONS=""
BZR_COMMIT_OPTIONS=""

DARCS_COMMIT_OPTIONS="-a"

#AVOID_DAILY_AUTOCOMMITS=1
#AVOID_SPECIAL_FILE_WARNING=1
#AVOID_COMMIT_BEFORE_INSTALL=1

HIGHLEVEL_PACKAGE_MANAGER=apt
LOWLEVEL_PACKAGE_MANAGER=dpkg
" > /etc/etckeeper/etckeeper.conf

git config --global user.email "bamboo_server@localhost"
git config --global user.name "Bamboo user"

cd /etc
etckeeper init
git add .
etckeeper commit 'initial commit'