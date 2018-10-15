#!/bin/bash

echo "Installing Docker"

# jq, net-tools required for troubleshooting needs
yum install -y yum-utils jq net-tools

# actual Docker Installation
yum-config-manager --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge

yum info docker-ce --disablerepo=* --enablerepo=docker-ce-edge && \
yum install -y docker-ce 

mkdir -p /etc/docker
cat <<EOF > /etc/docker/daemon.json
{
    "hosts": [
        "unix:///var/run/docker.sock",
        "tcp://127.0.0.1:2375",
        "$(hostname -I | awk '{print $2}')"
    ],
    "metrics-addr" : "0.0.0.0:9323",
    "experimental" : true,
    "log-driver": "journald",
    "labels": [
    	"host=$(hostname -s)"
    ]
}
EOF

systemctl daemon-reload
systemctl enable docker
systemctl restart docker

# The docker daemon binds to a Unix socket /var/run/docker.sock which is owned by root:docker
# Non-root user just needs to be added to the docker group.
usermod -aG docker vagrant

docker info