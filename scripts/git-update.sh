#!/usr/bin/env bash

# "log" command writes to /var/log/syslog with the specified tag
log () { logger -t LMFDB-GIT-UPDATE "$@"; }

echo running git update script >> $HOME/crontab.log

set -e # fail on error
set -u # show unused variables

# go into local lmfdb directory
cd $HOME/lmfdb

# Pull branches master, beta, prod from github (=upstream)

git checkout master
git pull
git checkout beta
git pull
git checkout prod
git pull

# Push branches beta and prod to $HOME/lmfdb.git (=lmfdb)

git checkout beta
git push lmfdb beta
git checkout prod
git push lmfdb prod

