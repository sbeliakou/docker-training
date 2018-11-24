FROM tomcat
LABEL maintainer="Siarhei Beliakou (sbeliakou@gmail.com)"

RUN wget -O /usr/local/tomcat/webapps/sample.war https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war