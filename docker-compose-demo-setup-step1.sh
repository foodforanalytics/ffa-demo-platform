#!/bin/bash

set -e

#VARIABLES
BASEDIR=$(basename $PWD)
KAFKACONNECTCONTAINER=$BASEDIR"_kafkaconnect-server_1"

#DOCKER

## Start Docker-demo yml
docker-compose -f docker-compose-demo-step1.yml up -d

## Restart kafka-schema-registry-container (cant force delay at startup)
docker container restart kafkaschemaregistry-server

## scale sparkworkers
docker-compose -f docker-compose-demo-step1.yml up -d --scale kafkaconnect-server=3

#ADD DELAY TO WAIT FOR ODOODEMO-DATA-MODULE-LOAD
sleep 300

#LOCALSTACK S3
docker exec -it management-server /bin/bash -c \
"aws --endpoint http://localstack-server:4566 s3 mb s3://local-raw \
&& aws --endpoint http://localstack-server:4566 s3 mb s3://local-cleansed \
&& aws --endpoint http://localstack-server:4566 s3 mb s3://local-curated \
&& aws --endpoint http://localstack-server:4566 s3 mb s3://local-consumption"

#KAFKA CONNECT

##deploy kakfa-connect-connectors --WIP: need to make "docker-stack" dynamically as it is the directoryname in which the shellscript sits.
docker exec -it $KAFKACONNECTCONTAINER /bin/bash -c \
"cd /tmp \
&& curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://$KAFKACONNECTCONTAINER:8083/connectors/ -d @odoodemo-src-register-postgres-schemaregistry-avro.json \
&& curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://$KAFKACONNECTCONTAINER:8083/connectors/ -d @odoodemo-dst-s3sink-schemaregistry-avro.json"


