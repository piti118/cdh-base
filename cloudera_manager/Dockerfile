from piti118/cdh-base:latest

#TODO: even thought it's agains cloudera recommendation we would separate maria db to separate container
RUN apt-get install -y cloudera-manager-daemons cloudera-manager-server cloudera-manager-agent

#TODO: These should be on separate hosts
RUN apt-get install -y avro-tools crunch flume-ng hadoop-hdfs-fuse hadoop-hdfs-nfs3 hadoop-httpfs hadoop-kms hbase-solr hive-hbase hive-webhcat hue-beeswax hue-hbase hue-impala hue-pig hue-plugins hue-rdbms hue-search hue-spark hue-sqoop hue-zookeeper impala impala-shell kite llama mahout oozie pig pig-udf-datafu search sentry solr-mapreduce spark-core spark-master spark-worker spark-history-server spark-python sqoop sqoop2 whirr

#JDBC DRIVER
RUN apt-get install libmysql-java

#TODO MOVE THIS
RUN echo "mariadb-server mysql-server/root_password password strangehat" | debconf-set-selections && \
    echo "mariadb-server mysql-server/root_password_again password strangehat" | debconf-set-selections && \
    apt-get install -y mariadb-server


#TODO just use config file and point it somewhere else
#prepare database for cloudera manager #this is a bad workaround though
RUN service mysql start && \
    bash /usr/share/cmf/schema/scm_prepare_database.sh --user=root --password=strangehat -v mysql cmf cmf cmfcmf

CMD service mysql start && service cloudera-scm-server start && tail -f /dev/null
