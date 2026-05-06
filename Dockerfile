FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV HADOOP_HOME=/opt/hadoop
ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:/opt/hadoop/bin:/opt/hadoop/sbin:/opt/spark/bin

RUN apt-get update && apt-get install -y \
    openjdk-11-jdk wget curl ssh rsync \
    && apt-get clean

EXPOSE 9870 8088 7077 2181 16000 9092

COPY scripts/start-services.sh /start-services.sh
RUN chmod +x /start-services.sh

CMD ["/start-services.sh"]
