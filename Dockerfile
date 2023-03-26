FROM debian:stable

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive

ARG BUILD_DATE
ARG VCS_REF

ENV SRV_PORT=65001 \
    HOAX_PORT=443 \
    NC_PORT=4443

# Apt packages to install
ENV PACKAGES "wget git python3-pip openssl"

RUN apt-get -y update && \
    apt-get install -y $PACKAGES && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN cd /opt && \
    git clone https://github.com/t3l3machus/Villain && \
    cd ./Villain && \
    pip3 install -r requirements.txt

WORKDIR /opt/Villain

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/isaudits/docker-villain" \
      org.label-schema.vcs-ref=$VCS_REF \