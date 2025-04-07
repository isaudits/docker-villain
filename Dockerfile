FROM kalilinux/kali-rolling

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive

ARG BUILD_DATE
ARG VCS_REF

ENV SRV_PORT=65001 \
    HOAX_PORT=443 \
    NC_PORT=4443 \
    INSECURE=false

RUN apt-get -y update && \
    apt-get install -y villain && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT /opt/entrypoint.sh

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/isaudits/docker-villain" \
      org.label-schema.vcs-ref=$VCS_REF \