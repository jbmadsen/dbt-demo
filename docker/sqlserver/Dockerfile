# We choose exact tag (not 'latest'), to be sure that new version wont break creating image
FROM mcr.microsoft.com/mssql/server:2017-CU17-ubuntu
MAINTAINER jbmadsen "jacob@jbmadsen.com"

USER root

RUN apt-get update \
  && apt-get install powershell -y

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy initialization scripts
COPY . /usr/src/app

# Grant permissions for the run-initialization script to be executable
RUN chmod +x /usr/src/app/run-initialization.sh

# Set environment variables, not to have to write them with docker run command
# Note: make sure that your password matches what is in the run-initialization script 
ENV SA_PASSWORD Secure1337Password
ENV ACCEPT_EULA Y
ENV MSSQL_PID Developer
ENV MSSQL_AGENT_ENABLED true

# Expose port 1433 in case accesing from other container
EXPOSE 1433

# Run Microsoft SQl Server and initialization script (at the same time)
# Note: If you want to start MsSQL only (without initialization script) you can comment bellow line out, CMD entry from base image will be taken
CMD /bin/bash ./entrypoint.sh