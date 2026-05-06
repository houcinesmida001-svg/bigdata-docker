cat > Dockerfile << 'EOF'
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME=/opt/spark
ENV ZOOKEEPER_HOME=/opt/zookeeper
ENV KAFKA_HOME=/opt/kafka
ENV HBASE_HOME=/opt/hbase
ENV HIVE_HOME=/opt/hive
ENV PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin:/opt/spark/bin:/opt/spark/sbin

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk wget curl ssh rsync \
    && apt-get clean

COPY config/hadoop/core-site.xml $HADOOP_HOME/etc/hadoop/
COPY config/hadoop/hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY config/hadoop/yarn-site.xml $HADOOP_HOME/etc/hadoop/
COPY config/hadoop/mapred-site.xml $HADOOP_HOME/etc/hadoop/
COPY scripts/start-services.sh /start-services.sh
RUN chmod +x /start-services.sh

EXPOSE 9870 8088 7077 2181 16000 9092

CMD ["/start-services.sh"]
EOF