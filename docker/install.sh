#!/bin/bash

# Install gcc 7.1
apt-get update
apt-get install build-essential software-properties-common -y
add-apt-repository ppa:ubuntu-toolchain-r/test -y
apt-get update
apt-get install gcc-7 g++-7 -y
update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 60 --slave /usr/bin/g++ g++ /usr/bin/g++-7
update-alternatives --config gcc

# Install boost
apt-get install -y wget unzip
wget https://dl.bintray.com/boostorg/release/1.64.0/source/boost_1_64_0.tar.bz2
tar --bzip2 -xf boost_1_64_0.tar.bz2
cd boost_1_64_0
./bootstrap.sh
./b2 install

cd ..
rm -rf boost_1_64_0
rm -f boost_1_64_0.tar.bz2

# Install GSL
wget https://github.com/Microsoft/GSL/archive/master.zip

unzip master.zip
cp -r GSL-master/include /usr/local

rm -rf GSL-master
rm -f master.zip

# Install Fake Function Framework
cd /usr/local/include
wget https://raw.githubusercontent.com/meekrosoft/fff/master/fff.h

# Update the Dynamic Linker Run Time Bindings
ldconfig
