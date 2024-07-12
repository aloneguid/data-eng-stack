FROM aloneguid/des-base:latest

# args contain immitable variables that can't be changed after build, but we redefine them as ENV to be used in the image
ARG JUPYTERLAB_VERSION=4.2.3
ENV JUPYTERLAB_PORT=8888
ARG SHARED_VOL=/opt/data
ARG SPARK_VERSION=3.5.1

ENV JUPYTERLAB_VERSION=$JUPYTERLAB_VERSION
ENV JUPYTERLAB_PORT=$JUPYTERLAB_PORT
ENV SHARED_VOL=$SHARED_VOL
ENV SPARK_VERSION=$SPARK_VERSION

# Install JupyterLab into virtual environment
RUN python3 -m venv /jupyterlab && \
    . /jupyterlab/bin/activate && \
    pip install jupyterlab==$JUPYTERLAB_VERSION pyspark==$SPARK_VERSION findspark pandas jupyterlab-git

RUN mkdir -p $SHARED_VOL/notebooks

# copy workload script
COPY run.sh /run.sh
RUN chmod +x /run.sh

# copy initial workspace files
COPY notebooks/ ${SHARED_VOL}/notebooks/

VOLUME $SHARED_VOL
CMD ["/bin/bash", "/run.sh"]