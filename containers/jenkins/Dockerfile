FROM jenkins/jenkins:latest

USER root

# Disable install wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
# Configuration-as-code config location
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/casc.yaml

# Copy list of plugins we want into the image
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the plugins
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Copy list of plugins we want into the image
COPY casc.yaml /usr/share/jenkins/ref/casc.yaml

# Install all other dependencies we are interested in using in our pipelines for ease of use
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
