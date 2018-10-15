FROM ubuntu

RUN apt-get update && apt-get install -y openssh-server openssh-client passwd sudo less 
RUN useradd devops && echo devops:devops | /usr/sbin/chpasswd

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

EXPOSE 22
ENTRYPOINT ["/sbin/init"]
