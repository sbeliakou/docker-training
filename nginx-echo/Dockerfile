FROM nginx

RUN apt-get update && \
    apt-get install -y wget figlet && \
    wget -O /usr/share/figlet/roman.flf http://www.figlet.org/fonts/roman.flf

COPY entrypoint.sh /

ENV MSG=""

ENTRYPOINT bash /entrypoint.sh

