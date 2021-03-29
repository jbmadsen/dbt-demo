#!/bin/bash

docker network connect --ip 172.23.0.5 containers_dbt-network postgres &
docker network connect --ip 172.23.0.6 containers_dbt-network redis &
docker network connect --ip 172.23.0.7 containers_dbt-network airflow-webserver &
docker network connect --ip 172.23.0.8 containers_dbt-network airflow-scheduler &
docker network connect --ip 172.23.0.9 containers_dbt-network airflow-worker &
docker network connect --ip 172.23.0.10 containers_dbt-network airflow-init &
docker network connect --ip 172.23.0.11 containers_dbt-network flower

