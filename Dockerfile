FROM quay.io/debezium/connect:2.7

USER root

RUN microdnf install -y wget && microdnf clean all

RUN mkdir -p /kafka/connect/kafka-connect-jdbc && \
    cd /kafka/connect/kafka-connect-jdbc && \
    wget https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/10.7.3/kafka-connect-jdbc-10.7.3.jar && \
    wget https://jdbc.postgresql.org/download/postgresql-42.7.4.jar

USER kafka
