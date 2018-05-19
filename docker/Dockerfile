FROM  gcc:latest
LABEL maintainer=byran@adgico.co.uk

ADD install.sh /

RUN /install.sh && \
    rm -f /install.sh

# gcov format changed in gcc-8 so cant yet do
# pip install gcovr
RUN apt-get update \
 && apt-get install --yes python-pip \
 && pip install git+https://github.com/gcovr/gcovr.git
