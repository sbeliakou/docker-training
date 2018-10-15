FROM centos

RUN yum install -y systemd openssh-server && systemctl enable sshd
RUN useradd devops && echo devops | passwd devops --stdin

EXPOSE 22
ENTRYPOINT ["/usr/sbin/init"]
