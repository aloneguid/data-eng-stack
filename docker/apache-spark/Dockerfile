FROM ubuntu:24.04

# args contain immitable variables that can't be changed after build, but we redefine them as ENV to be used in the image
ARG SHARED_VOL=/opt/data
ARG SPARK_VERSION=3.5.1
ARG HADOOP_VERSION=3
ARG SPARK_HOME=/opt/spark
ARG SCALA_VERSION=2.12

ENV SHARED_VOL=$SHARED_VOL
ENV SPARK_VERSION=$SPARK_VERSION
ENV HADOOP_VERSION=$HADOOP_VERSION
ENV SPARK_HOME=$SPARK_HOME
ENV SCALA_VERSION=$SCALA_VERSION

# Base: OS, Python, JDK 11
RUN apt-get update && \
    apt-get install -y python3 python3-pip openjdk-11-jdk curl

# Install Spark into /opt/spark (SPARK_HOME) directory
RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz
RUN tar -xf spark.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}
RUN echo "alias pyspark=${SPARK_HOME}/bin/pyspark" >> ~/.bashrc && \
    echo "alias spark-shell=${SPARK_HOME}/bin/spark-shell" >> ~/.bashrc && \
    mkdir ${SPARK_HOME}/logs && \
    mkdir /tmp/spark-events && \
    rm spark.tgz
COPY spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf

RUN mkdir -p $SHARED_VOL/spark-warehouse

# copy workload script
COPY workload.sh /des.sh
RUN chmod +x /des.sh


VOLUME $SHARED_VOL
CMD ["/bin/bash", "/des.sh"]