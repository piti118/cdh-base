FROM debian:jessie

WORKDIR /

#install jdk8
RUN \
    echo "===> add webupd8 repository..."  && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update


RUN echo "===> install Java"  && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    DEBIAN_FRONTEND=noninteractive  apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default


RUN echo "===> clean up..."  && \
    rm -rf /var/cache/oracle-jdk8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

##install CDH

#add and prioritize cloudera repo
COPY cloudera.list /etc/apt/sources.list.d/cloudera.list
COPY cloudera-cm.list /etc/apt/sources.list.d/cloudera-cm.list
COPY cloudera.pref /etc/apt/preferences.d/cloudera.pref

#add archive key
COPY archive.key /tmp/archive.key
RUN apt-key add /tmp/archive.key

RUN apt-get update

#Cloudera manager and client
RUN apt-get install -y cloudera-manager-daemons cloudera-manager-server cloudera-manager-agent

#TODO: CDH5
RUN apt-get install -y avro-tools crunch flume-ng hadoop-hdfs-fuse hadoop-hdfs-nfs3 hadoop-httpfs hadoop-kms hbase-solr hive-hbase hive-webhcat hue-beeswax hue-hbase hue-impala hue-pig hue-plugins hue-rdbms hue-search hue-spark hue-sqoop hue-zookeeper impala impala-shell kite llama mahout oozie pig pig-udf-datafu search sentry solr-mapreduce spark-core spark-master spark-worker spark-history-server spark-python sqoop sqoop2 whirr

#JDBC DRIVER
RUN apt-get install libmysql-java

CMD tail -f /dev/null