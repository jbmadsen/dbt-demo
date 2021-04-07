# Readme

This [docker-compose.yml](./docker-compose.yml) file extends the files in each of the sub-folders: Jenkins, SQLServer, Ubuntu. 

The containers created maintains the same configuration as each separate file, but adds a convenient way to spin up all containers at once, and adding them all to a shared network, allowing them to communicate. 

If everything is setup correctly according to the top level [readme.md](./../readme.md), everything should build, run and setup correctly, using:

```bash
$ docker-compose up -d
```

## So, what happens when I spin up the stack?

* All images are built and the containers are started
* Jenkins:
    * Jenkins is built and setup using [configuration-as-code](./jenkins/config/casc.yaml)
    * [Jobs](./jenkins/jobs/) are being copied into the image and setup in Jenkins later as part of the config
    * [Plugins](./jenkins/config/plugins.txt) are being installed
    * Python, dbt, ODBC drivers are all being installed as a lazy approach to run dbt command and interface with SQL Server \
    *(In a sane world, the entire Jenkins Pipeline Job would be executed separately in a Docker container, and this wouldn't be needed to be installed here)*
    * The [jenkins/data/]() folder (not found) is mounted as persistent storage for Jenkins
    * Jenkins is live on [localhost:8081](http:/localhost:8081)
* SQL Server:
    * SQL Server is built with a modified version of [this source](https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-mlservices)
    * Python and R machine learning packages are installed
    * SQL Server drivers and tools are installed, to allow calling needed subprocess commands from Python, to escape Machine Learning Python environment 
    * Python and dbt are installed to execute dbt locally for production, using Agent Jobs for scheduling, keeping everything self-contained once deployed to production. \
    *(This could easily be off-loaded to Airflow)* \
    *(For this demo, since we are running Linux SQL Server, I am executing dbt through the Machine Learning package. In a Windows environment, I would probably just use Powershell)*
    * [supervisord.conf](./sqlserver/supervisord.conf) runs [run-initialization.sh](./sqlserver/run-initialization.sh) as part of startup
    * [run-initialization.sh](./sqlserver/run-initialization.sh) in turn runs setup, creates Import, Staging and Common databases, and seeds the databases with data found in [this folder](./sqlserver/sql/seed/), and setups general Server configuration scripts in [config.sql](./sqlserver/sql/config/config.sql)
    * The [sqlserver/volumes/]() folder (not found) is mounted as persistent storage for SQL Server
    * SQL Server is live on [localhost:1433](http:/localhost:1433)
* Ubuntu:
    * Python, dbt, ODBC drivers are all being installed to run dbt command and interface with SQL Server
    * Local folder **~/git** is mounted in the container, to share the **dbt-demo** repository with the host OS, allowing me to use an editor in my host OS, and use dbt from the Ubuntu commandline inside the container
    * Ubuntu exposes port [localhost:8080](http:/localhost:8080) in order to serve ```dbt docs serve```
* All containers are added to the docker network **dbt-network** with static IPs for internal communication:
    * Jenkins running pipeline against SQL Server
    * Ubuntu running dbt commands against SQL Server

All in all, this should be a reproducible setup for demo purposes. All you need (except the RAM) is Git, and editor, and Docker with docker-compose. Oh, and an internet connection for pulling this repository.
