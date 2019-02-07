FROM gcc:latest
LABEL maintainer=byran@adgico.co.uk

RUN \
apt-get update && \
\
`# Install boost` \
apt-get install --yes \
  libboost-dev \
  libboost-all-dev && \
\
apt-get install --yes \
  wget \
  unzip && \
\
`# Install GSL` \
wget https://github.com/Microsoft/GSL/archive/master.zip && \
unzip master.zip && \
cp -r GSL-master/include /usr/local && \
rm -rf GSL-master && \
rm -f master.zip && \
\
`# Install Fake Function Framework` \
cd /usr/local/include && \
wget https://raw.githubusercontent.com/meekrosoft/fff/master/fff.h && \
\
apt-get remove --yes wget unzip && \
\
`# gcov format changed in gcc-8 so cant yet do [pip install gcovr]` \
apt-get install --yes python-pip && \
pip install git+https://github.com/gcovr/gcovr.git
