FROM ubuntu:18.04
MAINTAINER rotang <rotang@microsoft.com>

# packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    openjdk-8-jdk \
    unzip \
    libjansi-java \
    libcurl3 \
    iproute2 \
    libsasl2-modules && \
    rm -rf /var/lib/apt/lists/*

# Overall ENV vars
ENV LIVY_VERSION 0.5.0
ENV LIVY_VERSION_FULL livy-$LIVY_VERSION-incubating-bin
ENV LIVY_APP_PATH /apps/$LIVY_VERSION_FULL
ENV LIVY_DOWNLOAD_URL https://www-us.apache.org/dist/incubator/livy/$LIVY_VERSION-incubating/livy-$LIVY_VERSION-incubating-bin.zip

# Set Hadoop config directory
ENV HADOOP_CONF_DIR /etc/hadoop/conf

ENV SPARK_HOME /usr/lib/spark/

ENV LIVY_LOG_DIR /usr/local/livy-logs/

# Download and unzip Spark
RUN wget $LIVY_DOWNLOAD_URL && \
    unzip $LIVY_VERSION_FULL.zip -d /apps && \
    rm $LIVY_VERSION_FULL.zip
	
# Add custom files, set permissions
ADD entrypoint.sh .

RUN chmod +x entrypoint.sh

# Expose port
EXPOSE 8998

ENTRYPOINT ["/entrypoint.sh"]
