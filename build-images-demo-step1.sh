#!/bin/bash

set -e

## RDBMS - database storage engines
docker build -t $USER/postgresql:latest ./rdbms/postgresql

## Cloud blob storage - AWS S3 and Azure Blob Storage emulator 
docker build -t $USER/localstack:latest ./localstack

# Apache Zookeeper
docker build -t $USER/zookeeper:latest ./zookeeper

## Apache Kafka - data in motion (streaming) engine
docker build -t $USER/kafka:latest ./kafka
docker build -t $USER/kafkaconnect:latest ./kafkaconnect
docker build -t $USER/kafkaschemaregistry:latest ./kafkaschemaregistry

# Odoo - ERP-demo-application - front-end business
docker build -t $USER/odoo:latest ./odoo

## ubuntu management-image - ubuntu 20.04 container for managing the stack via cli
docker build -t $USER/management:latest ./management
