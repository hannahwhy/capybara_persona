#!/bin/sh

set -xe

FILE=chromedriver_linux64_23.0.1240.0.zip

mkdir -p /tmp/bin
cd /tmp/bin
wget https://chromedriver.googlecode.com/files/$FILE
unzip $FILE
