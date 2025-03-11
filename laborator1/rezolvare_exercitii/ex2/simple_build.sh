#!/bin/bash

# Build
docker build -t api-laborator-1-image .
docker network create -d bridge laborator1-db-network
docker volume create -d local laborator1-db-persistent-volume

# Run
docker run -d -v "$PWD"/init-db.sql:/docker-entrypoint-initdb.d/init-db.sql -v laborator1-db-persistent-volume:/var/lib/postgresql/data --network=laborator1-db-network -e POSTGRES_USER=admin -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=books --name laborator1-db postgres
docker run -d --network=laborator1-db-network -e PGUSER=admin -e PGPASSWORD=admin -e PGDATABASE=books -e PGHOST=laborator1-db -e PGPORT=5432 --name laborator1-api -p 5555:80 api-laborator-1-image