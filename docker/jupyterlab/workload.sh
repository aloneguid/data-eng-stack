# this becomes /des.sh
# DES_WORKLOAD environment variable tells which workload to run

# Spark Master
if [ "$DES_WORKLOAD" == "spark-master" ];
then
  echo "Starting Spark Master in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-master.sh >> logs/spark-master.out
  # start-master.sh will exit immediately, so we need to keep the container running
  tail -f logs/spark-master.out
# Spark Worker
elif [ "$DES_WORKLOAD" == "spark-worker" ]
then
  echo "Starting Spark Worker in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-worker.sh spark://"${SPARK_MASTER_HOST}":"${SPARK_MASTER_PORT}" >> logs/spark-worker.out
  tail -f logs/spark-worker.out
# Spark History Server
elif [ "$DES_WORKLOAD" == "spark-history-server" ]
then
  echo "Starting Spark History Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-history-server.sh >> logs/spark-history-server.out
  tail -f logs/spark-history-server.out
# Spark Thrift (JDBC/ODBC) server
elif [ "$DES_WORKLOAD" == "spark-thrift-server" ]
then
  echo "Starting Spark Thrift Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-thriftserver.sh >> logs/spark-thrift-server.out
  tail -f logs/spark-thrift-server.out
# Spark Connect Server
elif [ "$DES_WORKLOAD" == "spark-connect-server" ]
then
  echo "Starting Spark Connect Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-connect-server.sh --packages org.apache.spark:spark-connect_"$SCALA_VERSION":"$SPARK_VERSION" >> logs/spark-connect-server.out
  tail -f logs/spark-connect-server.out
# JupyterLab
elif [ "$DES_WORKLOAD" == "jupyterlab" ]
then
  echo "Starting JupyterLab in $SHARED_VOL/notebooks"
  . /jupyterlab/bin/activate
  cd "$SHARED_VOL/notebooks" || exit

  export PYSPARK_DRIVER_PYTHON=jupyter
  export PYSPARK_DRIVER_OPTS="notebook --no-browser --port=$JUPYTERLAB_PORT"

  jupyter lab --ip=0.0.0.0 --port="$JUPYTERLAB_PORT" --no-browser --allow-root --NotebookApp.token='' --NotebookApp.password=''
fi