# this becomes /des.sh
# DES_WORKLOAD environment variable tells which workload to run

# Spark Master
if [ "$DES_WORKLOAD" == "spark-master" ];
then
  echo "Starting Spark Master in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-master.sh >> logs/spark-master.out
  # start-master.sh will exit immediately, so we need to keep the container running
  tail -f logs/*
# Spark Worker
elif [ "$DES_WORKLOAD" == "spark-worker" ]
then
  echo "Starting Spark Worker in $SPARK_HOME, pointed to $SPARK_MASTER_HOST:$SPARK_MASTER_PORT"
  cd $SPARK_HOME || exit
  ./sbin/start-worker.sh spark://"${SPARK_MASTER_HOST}":"${SPARK_MASTER_PORT}" >> logs/spark-worker.out
  tail -f logs/*
# Spark History Server
elif [ "$DES_WORKLOAD" == "spark-history-server" ]
then
  echo "Starting Spark History Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-history-server.sh >> logs/spark-history-server.out
  tail -f logs/*
# Spark Thrift (JDBC/ODBC) server
elif [ "$DES_WORKLOAD" == "spark-thrift-server" ]
then
  echo "Starting Spark Thrift Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-thriftserver.sh >> logs/spark-thrift-server.out
  tail -f logs/*
# Spark Connect Server
elif [ "$DES_WORKLOAD" == "spark-connect-server" ]
then
  echo "Starting Spark Connect Server in $SPARK_HOME"
  cd $SPARK_HOME || exit
  ./sbin/start-connect-server.sh --packages org.apache.spark:spark-connect_"$SCALA_VERSION":"$SPARK_VERSION" >> logs/spark-connect-server.out
  tail -f logs/*
fi