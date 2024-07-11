# Data Engineering Stack

Minimalistic data engineer's stack for local Spark development. Inspired by [this project](https://github.com/cluster-apps-on-docker/spark-standalone-cluster-on-docker).

Goals:
- Minimalistic. One small image containing different workloads.
- Easy to use. Just run `docker-compose up`. 
- Supports external IDEs (JetBrains, VSCode, etc.)
- Easy to upgrade.

Includes:
- Apache Spark
  - [master](http://localhost:9090)
  - [worker #1](http://localhost:9091)
  - [history server](http://localhost:18080)
  - **thrift server**. Connect using `jdbc:hive2://localhost:10000` ([instructions](https://spark.apache.org/docs/latest/sql-distributed-sql-engine.html)).
  - Persistent metastore (Hive).
- [Jupyter Lab](http://localhost:8888)
