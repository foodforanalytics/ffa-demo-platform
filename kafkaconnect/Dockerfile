FROM debezium/connect:1.6

#SET ENVIRONMENT_VARIABLES FOR AWS CREDENTIALS
ENV AWS_ACCESS_KEY_ID=mock
ENV AWS_SECRET_ACCESS_KEY=mock
ARG CONFLUENT_S3_CONNECTOR_VERSION=10.0.0
ARG CONFLUENT_AB_CONNECTOR_VERSION=1.6.2
USER root
RUN yum install -y wget unzip

#INSTALL Confluent S3 Sink Connector
RUN wget https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-s3/versions/${CONFLUENT_S3_CONNECTOR_VERSION}/confluentinc-kafka-connect-s3-${CONFLUENT_S3_CONNECTOR_VERSION}.zip && \
    unzip confluentinc-kafka-connect-s3-${CONFLUENT_S3_CONNECTOR_VERSION}.zip && \
    mv $KAFKA_HOME/confluentinc-kafka-connect-s3-${CONFLUENT_S3_CONNECTOR_VERSION} /$KAFKA_CONNECT_PLUGINS_DIR && \
    rm confluentinc-kafka-connect-s3-${CONFLUENT_S3_CONNECTOR_VERSION}.zip

#Install confluent Azure Blob Storage Sink Connector
RUN wget https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-azure-blob-storage/versions/${CONFLUENT_AB_CONNECTOR_VERSION}/confluentinc-kafka-connect-azure-blob-storage-${CONFLUENT_AB_CONNECTOR_VERSION}.zip && \
    unzip confluentinc-kafka-connect-azure-blob-storage-${CONFLUENT_AB_CONNECTOR_VERSION}.zip && \
    mv $KAFKA_HOME/confluentinc-kafka-connect-azure-blob-storage-${CONFLUENT_AB_CONNECTOR_VERSION} /$KAFKA_CONNECT_PLUGINS_DIR && \
    rm confluentinc-kafka-connect-azure-blob-storage-${CONFLUENT_AB_CONNECTOR_VERSION}.zip

COPY connectorconfigs/*.* /tmp/

USER kafka