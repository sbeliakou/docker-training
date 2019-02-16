#!/bin/bash

cd $(dirname ${TOMCAT_HOME})
wget -q -O tomcat.zip https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_VERSION%%.*}/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.zip
unzip tomcat.zip
mv apache-tomcat-${TOMCAT_VERSION} tomcat
rm -f tomcat.zip
useradd tomcat -u ${TOMCAT_ID} --no-create-home -d ${TOMCAT_HOME}
chown -R tomcat: ${TOMCAT_HOME}

