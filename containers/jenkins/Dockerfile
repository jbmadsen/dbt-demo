FROM jenkins/jenkins:latest
MAINTAINER jbmadsen "jacob@jbmadsen.com"

USER root

RUN apt-get update \
  && apt-get install apt-file -y \
  && apt-file update \
  && apt-get install curl -y \
  && apt-get install git -y \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip
