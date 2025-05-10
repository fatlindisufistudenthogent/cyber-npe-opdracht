# Dockerfile voor kwetsbare Apache Tomcat 9.0.30 (CVE-2020-1938)

FROM ubuntu:20.04

# Environment variabelen
ENV TOMCAT_VERSION=9.0.30
ENV TOMCAT_DIR=/opt/tomcat
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV DEBIAN_FRONTEND=noninteractive

# Installeer dependencies
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Maak tomcat-gebruiker aan
RUN useradd -m -U -s /bin/false tomcat

# Download en installeer Tomcat 9.0.30
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz -O /tmp/tomcat.tar.gz && \
    mkdir -p ${TOMCAT_DIR} && \
    tar -xzf /tmp/tomcat.tar.gz -C ${TOMCAT_DIR} --strip-components=1 && \
    rm /tmp/tomcat.tar.gz && \
    chown -R tomcat:tomcat ${TOMCAT_DIR} && \
    chmod -R 755 ${TOMCAT_DIR}

# Configureer AJP-connector expliciet
RUN sed -i '/<Connector port="8080"/i \
    <Connector port="8009" protocol="AJP/1.3" address="0.0.0.0" secretRequired="false" />' ${TOMCAT_DIR}/conf/server.xml

# Voeg een testbestand toe om de kwetsbaarheid te demonstreren
RUN echo "<web-app><display-name>TestApp</display-name></web-app>" > ${TOMCAT_DIR}/webapps/ROOT/WEB-INF/web.xml

# Expose poorten
EXPOSE 8080 8009

# Start Tomcat als tomcat-gebruiker
USER tomcat
CMD ["sh", "-c", "${TOMCAT_DIR}/bin/catalina.sh run"]