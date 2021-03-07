# Docker file for a slim Ubuntu-based Python3 image

FROM ubuntu:latest
MAINTAINER jbmadsen "jacob@jbmadsen.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install apt-file -y \
  && apt-file update \
  && apt-get install nano -y \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/* \
  && apt update \
  && apt-get install unixodbc-dev -y \
  && pip install dbt \
  && pip install dbt-sqlserver

WORKDIR /usr/local/bin

CMD ["bash"]