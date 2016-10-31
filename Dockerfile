##
# NAME              : iadvize/maxscale
# VERSION           : 2.0
# DOCKER-VERSION    : 1.12
# DESCRIPTION       : maxscale (2.0)
# DEPENDENCY        : none
# TO_BUILD          : docker build --pull=true --no-cache --rm -t iadvize/maxscale:2.0 -t iadvize/maxscale:latest .
# TO_SHIP           : docker push iadvize/maxscale:2.0 && docker push iadvize/maxscale:latest
# TO_RUN            : docker run --rm -h maxscale --name maxscale -p 3306:3306 iadvize/maxscale:2.0
##

FROM iadvize/debian:jessie

MAINTAINER Samuel BERTHE <samuel.berthe@iadvize.com>


ENV DEBIAN_FRONTEND="noninteractive" \
    MAXSCALE_VERSION="2.0.1" \
    PACKAGES="maxscale"

RUN echo "deb http://downloads.mariadb.com/enterprise/6whk-mygr/mariadb-maxscale/$MAXSCALE_VERSION/debian jessie main" | tee -a /etc/apt/sources.list.d/maxscale.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 8167EE24 && \
    apt-get update && \
    apt-get install -yq --no-install-recommends $PACKAGES && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/maxscale", "-d", "-l", "stdout"]

ADD router/maxscale.cnf /etc/maxscale.cnf

# Expose ports.
EXPOSE 3306
