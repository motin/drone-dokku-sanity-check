#!/bin/bash

# enable debug
set -x

# fail on any error
set -o errexit

echo "===== Prepare some sample repository to deploy with dokku ====="
mkdir /tmp/empty-git
cd /tmp/empty-git
git init
git checkout -b master
echo 'foo' > index.php
git add index.php
echo 'echo Hello; echo "bar" > index.php;' > shell-script.sh
chmod +x shell-script.sh
git add shell-script.sh
git commit -m "Dokku sanity check commit"
echo "Done"
echo
echo "===== Check access to dokku ===="
git push dokku@$DOKKU_HOST:sanity-check master:master -f
echo "Done"
echo
echo "===== Check output of remote dokku commands ===="
ssh dokku@$DOKKU_HOST run sanity-check /bin/bash /app/shell-script.sh
echo "Done"

exit 0
