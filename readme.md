# dbt Demo project in Docker containers

Current todo for running project (many steps can be done in separate terminals as needed):

Starting docker containers:
* cd containers/sqlserver
* docker-compose up -d
* cd ../ubuntu
* docker-compose up -d

Connecting containers to shared network:
* docker network create --subnet=172.23.0.0/16 --gateway=172.23.0.1 dbt-network 
* docker network connect --ip 172.23.0.2 dbt-network sql-server-db
* docker network connect --ip 172.23.0.3 dbt-network ubuntu

Testing everything works:
* docker exec -it ubuntu bash   // navigating into ubuntu bash terminal to execute dbt commands
* #: cd dbt-demo/src
* #: dbt debug --profiles-dir /home/git/dbt-demo/profiles

Hopefully you'll see something like this:

```bash
Configuration:
 - profiles.yml file [OK found and valid]
 - dbt_project.yml file [OK found and valid]

Required dependencies:
 - git [OK found]

Connection:
  [...]
  Connection test: OK connection ok
```


# Additional tools

I am using the following tools with this project:

* Docker
* Docker Compose
* Git
* Visual Studio Code
* Terminal

