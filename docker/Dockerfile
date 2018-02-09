FROM  gcc:latest
LABEL maintainer=byran@adgico.co.uk

ADD install.sh /

RUN /install.sh && \
    rm -f /install.sh
