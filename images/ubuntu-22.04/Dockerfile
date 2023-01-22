# Ubuntu 22.04
FROM ubuntu:jammy-20221130

LABEL authors="wexample <contact@wexample.com>"

# Copy entrypoint.
COPY ./addons/docker/images/ubuntu-22.04/entrypoint.sh /docker-entrypoint-ubuntu.sh

RUN export DEBIAN_FRONTEND=noninteractive && \
    echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    apt-get update && \
    apt-get install \
    apt-utils \
    cron \
    curl \
    git \
    gnupg2 \
    lsb-release \
    tzdata \
    unzip \
    wget \
    zip \
    -yqq && \
    echo "Europe/Paris" > /etc/timezone && \
    rm /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    touch /var/default.cron && \
    chmod +x /docker-entrypoint-ubuntu.sh && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/docker-entrypoint-ubuntu.sh"]
