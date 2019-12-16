FROM tutum/centos:latest
    MAINTAINER jinhaoxun
WORKDIR /usr
RUN mkdir /usr/local/java
RUN mkdir /usr/local/maven
RUN mkdir /usr/local/service
RUN mkdir /usr/local/nginx
RUN mkdir /usr/local/zookeeper
RUN mkdir /usr/local/dubbo
RUN mkdir /usr/local/keepalived
RUN mkdir /usr/local/rabbitmq
RUN mkdir /usr/local/rocketmq
RUN mkdir /usr/local/redis
RUN mkdir /usr/local/mysql
RUN mkdir /usr/local/oracle

RUN yum install -y gcc
RUN yum install -y gcc-c++
RUN yum install -y pcre pcre-devel
RUN yum install -y zlib zlib-devel
RUN yum install -y openssl openssl-devel
RUN yum install -y vim
RUN yum install -y lsof
RUN yum install -y zip unzip


COPY jdk-8u221-linux-x64.tar.gz /usr/local/java/
COPY apache-maven-3.6.3-bin.tar.gz /usr/local/maven/
COPY apecome.top_nginx.zip /usr/local/nginx/
COPY nginx.conf /usr/local/nginx/
COPY nginx-1.6.2.tar.gz /usr/local/nginx/
COPY apache-zookeeper-3.5.5-bin.tar.gz /usr/local/zookeeper/
COPY zoo.cfg /usr/local/zookeeper/
COPY dubbo-admin-develop.zip /usr/local/dubbo/
COPY dubbo-admin-master.zip /usr/local/dubbo/
COPY keepalived-2.0.19.tar.gz /usr/local/keepalived/
COPY keepalived.conf /usr/local/keepalived/
COPY nginx_check.sh /usr/local/keepalived/
COPY redis-5.0.5.tar.gz /usr/local/redis/

ENV PATH /usr/local/redis/bin:$PATH
ENV PATH /usr/local/zookeeper/apache-zookeeper-3.5.5-bin/bin:$PATH
ENV PATH /usr/local/nginx/sbin:$PATH
ENV PATH /usr/local/keepalived/sbin:$PATH
ENV PATH /usr/local/maven/apache-maven-3.6.3/bin:$PATH

export PATH=$PATH:/usr/local/redis/bin
export PATH=$PATH:/usr/local/zookeeper/apache-zookeeper-3.5.5-bin/bin
export PATH=$PATH:/usr/local/nginx/sbin
export PATH=$PATH:/usr/local/keepalived/sbin

ENV JAVA_HOME /usr/local/java/jdk1.8.0_221
ENV JRE_HOME $JAVA_HOME/jre
ENV CLASSPATH $JAVA_HOME/bin/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH
ENV PATH $JAVA_HOME/bin:$PATH

EXPOSE 80
EXPOSE 8443
EXPOSE 3306
EXPOSE 6379
EXPOSE 2181
EXPOSE 9090
EXPOSE 9091
EXPOSE 9092


docker run -dit --name redis-4.0 -p 6379:6379 -v  /usr/local/docker/redis/data:/data redis:4.0 redis-server --appendonly yes --requirepass "root"
docker exec -it my-redis bash
docker run -dit --name mysql-5.7 -p 3306:3306 -v /usr/local/docker/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=root mysql:5.7



# Docker image for springboot file run
# VERSION 0.0.1
# Author: eangulee
# 基础镜像使用java
FROM java:8
# 作者
MAINTAINER eangulee <eangulee@gmail.com>
# VOLUME 指定了临时文件目录为/tmp。
# 其效果是在主机 /var/lib/docker 目录下创建了一个临时文件，并链接到容器的/tmp
VOLUME /tmp
# 将jar包添加到容器中并更名为app.jar
ADD demo-0.0.1-SNAPSHOT.jar app.jar
# 运行jar包
RUN bash -c 'touch /app.jar'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]





FROM java:8
MAINTAINER jinhaoxun
VOLUME /tmp
COPY dubbo-demo-web-1.0.0.jar app.jar
RUN bash -c 'touch /app.jar'
EXPOSE 6060
EXPOSE 8440

# 定义环境变量，会被后续的RUN命令使用，并且在容器运行期间保持
# 配置文件参数，默认为test环境
ENV PROFILES=""
# java启动参数，默认为空
# ENV PARAMS=""
# ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=prod-6060", "> /usr/local/dubbo/tomcat/dubbo-demo-web/6060+8440/tomcat.log"]
ENTRYPOINT ["sh","-c","java -jar app.jar --spring.profiles.active=$PROFILES "]

# docker run -dit --name=dubbo-demo-web-6060 -p 6060:6060 -p 8440:8440 -e PROFILES="prod-6060" dubbo-demo-web-6060