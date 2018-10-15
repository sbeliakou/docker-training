FROM centos

RUN yum install -y systemd openssh-server openssh-client passwd sudo less && \
    systemctl enable sshd
RUN useradd devops && echo devops | passwd devops --stdin

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US

EXPOSE 22
ENTRYPOINT ["/usr/sbin/init"]
