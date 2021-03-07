# Docker file for a slim Ubuntu-based Python3 image
# Added few other items for:
#   Python and pip
#   dbt
#   dbt-sqlserver: https://github.com/dbt-msft/dbt-sqlserver
#   OLDB driver: https://docs.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-ver15

FROM ubuntu:20.10
MAINTAINER jbmadsen "jacob@jbmadsen.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install apt-file -y \
  && apt-file update \
  && apt-get install nano -y \
  && apt-get install curl -y \
  && apt-get install git -y \
  && apt-get install -y python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/* \
  && apt update \
  && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
  && curl https://packages.microsoft.com/config/ubuntu/20.10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
  && apt-get update \
  && ACCEPT_EULA=Y apt-get install msodbcsql17 -y \
  && ACCEPT_EULA=Y apt-get install mssql-tools -y \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
  && apt-get install unixodbc-dev -y \
  && pip install dbt \
  && pip install dbt-sqlserver

WORKDIR /home/git

CMD ["bash"]