#!/usr/bin/env bash

set -xe

BROWSERID_PATH=$TRAVIS_BUILD_DIR/features/support/browserid
cd $BROWSERID_PATH

echo 'Installing BrowserID dependencies...'
npm install > /tmp/browserid_setup.log 2>&1
if [ $? -eq 0 ]; then
	echo 'OK'
else
	echo 'Error encountered, full setup log follows'
	cat /tmp/browserid_setup.log
	exit 1
fi
