# Maintainers: Microsoft Corporation 
FROM ubuntu:18.04

USER root

# Create app directory
RUN mkdir -p /usr/src/app

# Copy initialization scripts
COPY ./sql /usr/src/app/sql
# Copy initialization files
COPY ./run-initialization.sh /usr/src/app/run-initialization.sh
# copy in supervisord conf file
COPY ./supervisord.conf /usr/local/etc/supervisord.conf

# install supporting packages
RUN apt-get update && \
    apt-get install -y apt-transport-https \
                       curl \
                       supervisor \
                       fakechroot \
                       locales \
                       iptables \
                       sudo \
                       wget \
                       curl \
                       zip \
                       unzip \
                       make \ 
                       bzip2 \ 
                       m4 \
                       apt-transport-https \
                       tzdata \
                       libnuma-dev \
                       libsss-nss-idmap-dev \
                       software-properties-common

# Adding custom MS repository
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list > /etc/apt/sources.list.d/mssql-server-2019.list
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# install SQL Server ML services R and Python packages which will also install the mssql-server pacakge, the package for SQL Server itself
# if you want to install only Python or only R, you can add/remove the package as needed below
RUN apt-get update && \
    apt-get install -y mssql-mlservices-packages-r \
                       mssql-mlservices-packages-py \
                       && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/apt/cache/* /tmp/* /var/tmp/* /var/lib/apt/lists

# install SQL Server drivers and tools
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y unixodbc-dev mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

# install other missing functionality
RUN apt-get update \
    && apt-get install git -y \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 --no-cache-dir install --upgrade pip \
    && rm -rf /var/lib/apt/lists/* \
    && pip install dbt \
    && pip install dbt-sqlserver

# run checkinstallextensibility.sh
RUN /opt/mssql/bin/checkinstallextensibility.sh && \
    # set/fix directory permissions and create default directories
    chown -R root:root /usr/src/app/run-initialization.sh && \
    chown -R root:root /opt/mssql/bin/launchpadd && \
    chown -R root:root /opt/mssql/bin/setnetbr && \
    mkdir -p /var/opt/mssql-extensibility/data && \
    mkdir -p /var/opt/mssql-extensibility/log && \
    chown -R root:root /var/opt/mssql-extensibility && \
    chmod -R 777 /var/opt/mssql-extensibility && \
    mkdir -p /usr/src/app/git && \
    chown -R root:root /usr/src/app/git && \
    chmod -R 777 /usr/src/app/git && \
    # locale-gen
    locale-gen en_US.UTF-8

# expose SQL Server port
EXPOSE 1433

# start services with supervisord
CMD /usr/bin/supervisord -n -c /usr/local/etc/supervisord.conf
