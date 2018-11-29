FROM openjdk:7-jre

ARG TOMCAT_ID=1000
ARG TOMCAT_HOME=/opt/tomcat
ARG TOMCAT_VERSION=7.0.91

RUN wget -q -O /opt/tomcat.zip http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-${TOMCAT_VERSION%%.*}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip && \
    cd $(dirname ${TOMCAT_HOME}) && unzip tomcat.zip && \
    mv apache-tomcat-${TOMCAT_VERSION} tomcat && \
    rm -f /opt/tomcat.zip && \
    useradd tomcat -u ${TOMCAT_ID} --no-create-home -d ${TOMCAT_HOME} && \
    chown -R tomcat: ${TOMCAT_HOME}

USER tomcat
ENV CATALINA_HOME=${TOMCAT_HOME}

VOLUME ${TOMCAT_HOME}/webapps

EXPOSE 8080
CMD /bin/bash ${CATALINA_HOME}/bin/catalina.sh run
