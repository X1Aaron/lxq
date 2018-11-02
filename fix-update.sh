#!/bin/bash
cd /opt/lxq/
git fetch --all # don't we need the git url here?
git reset --hard origin/master
chmod a+x lxq
chmod a+x fix-update.sh
