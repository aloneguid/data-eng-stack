FROM ubuntu:24.04

# args contain immitable variables that can't be changed after build
ARG JUPYTERLAB_VERSION=4.2.3
ARG SHARED_WORKSPACE=/opt/workspace
ARG SPARK_VERSION=3.3.2
ARG HADOOP_VERSION=3
ARG SPARK_HOME=/opt/spark

# env vars can be changed when container runs
ENV JUPYTERLAB_PORT=8888
ENV SPARK_MASTER_HOST=spark-master
ENV SPARK_MASTER_PORT=7077
ENV SPARK_HOME=$SPARK_HOME
ENV PYSPARK_PYTHON=python3
ENV SHARED_WORKSPACE=$SHARED_WORKSPACE

# Base: OS, Python, JDK 11
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv openjdk-11-jdk curl

RUN mkdir -p $SHARED_WORKSPACE

# Install Spark into /opt/spark (SPARK_HOME) directory
RUN curl https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz
RUN tar -xf spark.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} ${SPARK_HOME}
RUN echo "alias pyspark=${SPARK_HOME}/bin/pyspark" >> ~/.bashrc && \
    echo "alias spark-shell=${SPARK_HOME}/bin/spark-shell" >> ~/.bashrc && \
    mkdir ${SPARK_HOME}/logs && \
    rm spark.tgz

# Install JupyterLab into virtual environment
RUN python3 -m venv /jupyterlab && \
    . /jupyterlab/bin/activate && \
    pip install jupyterlab==$JUPYTERLAB_VERSION pyspark==$SPARK_VERSION findspark pandas

# copy workload script
COPY workload.sh /des.sh
RUN chmod +x /des.sh

# copy initial workspace files
COPY workspace/ ${SHARED_WORKSPACE}/

VOLUME $SHARED_WORKSPACE
CMD ["/bin/bash", "/des.sh"]