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
  && pip3 --no-cache-dir install --upgrade pip \
  && apt update \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/ubuntu/20.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install msodbcsql17 -y \
  && ACCEPT_EULA=Y apt-get install mssql-tools -y \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
  && apt-get install unixodbc-dev -y 