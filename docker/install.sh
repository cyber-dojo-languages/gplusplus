#!/bin/bash
set -e

apt-get update

# Install boost
apt-get install --yes libboost-dev libboost-all-dev

# Install GSL
apt-get install --yes wget unzip
wget https://github.com/Microsoft/GSL/archive/master.zip
unzip master.zip
cp -r GSL-master/include /usr/local
rm -rf GSL-master
rm -f master.zip

# Install Fake Function Framework
cd /usr/local/include
wget https://raw.githubusercontent.com/meekrosoft/fff/master/fff.h

apt-get remove --yes wget unzip