FROM httpd
LABEL maintainer="Siarhei Beliakou (sbeliakou@gmail.com)"

RUN apt-get update && apt-get install -y curl && apt-get clean