#!/bin/bash -Eeu

DEBIAN_FRONTEND=noninteractive

# Fix up broken gfortran (which boost depends on) redirects
# https://www.gitmemory.com/issue/docker-library/gcc/57/499172974
dpkg-divert --remove --no-rename /usr/bin/gfortran
dpkg-divert --divert /usr/bin/gfortran.orig --rename /usr/local/bin/gfortran
apt install --yes libblas-dev

# Install boost
apt-get install --yes libboost-dev libboost-all-dev
apt-get install --yes wget unzip

# Install GSL
wget https://github.com/microsoft/GSL/archive/v3.1.0.zip
unzip v3.1.0.zip
cp -r GSL-3.1.0/include /usr/local
rm -rf GSL-3.1.0
rm -f master.zip

# Install Fake Function Framework
cd /usr/local/include
wget https://raw.githubusercontent.com/meekrosoft/fff/master/fff.h
apt-get remove --yes wget unzip

# Install gcovr
apt-get install --yes gcovr
