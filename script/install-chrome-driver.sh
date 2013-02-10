#!/bin/sh

set -xe

FILE=chromedriver_linux32_26.0.1383.0.zip

mkdir -p /tmp/bin
cd /tmp/bin
wget https://chromedriver.googlecode.com/files/$FILE
unzip $FILE
