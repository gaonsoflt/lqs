FROM ubuntu:16.04

ENV LQS_VERSION 0.1
# install apps
RUN set -ex \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        vim \
        git \
        wget \
        software-properties-common \
        python-software-properties \
    && rm -rf /var/lib/apt/lists\*

# env for tomcat
ENV TOMCAT_VERSION 7.0.81
ENV TOMCAT_MAJOR 7
ENV TOMCAT_TGZ_FALLBACK_URL https://archive.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
ENV CATALINA_HOME /usr/local/tomcat$TOMCAT_MAJOR
ENV PATH $CATALINA_HOME/bin:$PATH
RUN mkdir -p "$CATALINA_HOME"

# let "Tomcat Native" live somewhere isolated
ENV TOMCAT_NATIVE_LIBDIR $CATALINA_HOME/native-jni-lib
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}$TOMCAT_NATIVE_LIBDIR

# install tomcat
RUN set -x \
    && wget -O tomcat$TOMCAT_MAJOR.tar.gz "$TOMCAT_TGZ_FALLBACK_URL" \
    && tar -xvf tomcat$TOMCAT_MAJOR.tar.gz \
    && mv apache-tomcat-$TOMCAT_VERSION/* "$CATALINA_HOME" \
    && rm -rf apache-tomcat-$TOMCAT_VERSION \
    && rm -rf tomcat$TOMCAT_MAJOR.tar.gz

#
# Oracle Java 8 Dockerfile
#
# https://github.com/dockerfile/java
# https://github.com/dockerfile/java/tree/master/oracle-java8
#
# install java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# install maven
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends maven \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/maven

# clone git
RUN set -x \
    && mkdir ~/temp \
    && cd ~/temp \
    && git clone https://github.com/gaonsoflt/lqs.git

# Define working directory.
WORKDIR $CATALINA_HOME

# change timezone
RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/* && ln -s /usr/local/bin/docker-entrypoint.sh /
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8080
#CMD ["/bin/bash"]
#CMD ["catalina.sh", "run"]
