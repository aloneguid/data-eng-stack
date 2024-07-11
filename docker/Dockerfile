FROM ubuntu:24.04

# args contain immitable variables that can't be changed after build
ARG JUPYTERLAB_VERSION=4.2.3
ARG SHARED_VOL=/opt/data
ARG SPARK_VERSION=3.5.1
ARG HADOOP_VERSION=3
ARG SPARK_HOME=/opt/spark

# env vars can be changed when container runs
ENV JUPYTERLAB_PORT=8888
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077
ENV SPARK_HOME=$SPARK_HOME
ENV PYSPARK_PYTHON=python3
ENV SHARED_VOL=$SHARED_VOL

# Base: OS, Python, JDK 11
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv openjdk-11-jdk curl

# Install JupyterLab into virtual environment
RUN python3 -m venv /jupyterlab && \
    . /jupyterlab/bin/activate && \
    pip install jupyterlab==$JUPYTERLAB_VERSION pyspark==$SPARK_VERSION findspark pandas

# Install Spark into /opt/spark (SPARK_HOME) directory
RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz
RUN tar -xf spark.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}
RUN echo "alias pyspark=${SPARK_HOME}/bin/pyspark" >> ~/.bashrc && \
    echo "alias spark-shell=${SPARK_HOME}/bin/spark-shell" >> ~/.bashrc && \
    mkdir ${SPARK_HOME}/logs && \
    mkdir /tmp/spark-events && \
    rm spark.tgz \
COPY spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf

RUN mkdir -p $SHARED_VOL/notebooks && \
    mkdir -p $SHARED_VOL/spark-warehouse

# copy workload script
COPY workload.sh /des.sh
RUN chmod +x /des.sh

# copy initial workspace files
COPY notebooks/ ${SHARED_VOL}/notebooks/

VOLUME $SHARED_VOL
CMD ["/bin/bash", "/des.sh"]