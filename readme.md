# dbt Demo project in Docker containers

Todo for running project:

Starting docker containers:
> docker-compose -f containers/docker-compose.yml up -d

Testing everything works:

> docker exec -it ubuntu bash-ext \
> #: cd dbt-demo/src \
> #: dbt debug --profiles-dir /home/git/dbt-demo/profiles

Which should display the following, once everything has started up:

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


# Tools used

* Docker
* Docker Compose
* Git
* Visual Studio Code
* Windows Terminal

