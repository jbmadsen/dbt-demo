# Manual network setup

## Remove old network if any

> docker network rm dbt-network 


## Create new newtork

> docker network create --subnet=172.23.0.0/16 --gateway=172.23.0.1 dbt-network 


## Add containers to network

> docker network connect --ip 172.23.0.2 dbt-network sql-server-db

> docker network connect --ip 172.23.0.3 dbt-network ubuntu

> docker network connect --ip 172.23.0.4 dbt-network jenkins


### Inspect network if needed

> docker network inspect dbt-network

