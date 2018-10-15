#!/bin/bash

yum install -y git 

cd /tmp
git clone https://github.com/shreben/prometheus.git
cd prometheus/
docker-compose up -d && \
cat <<EOF
http://$(hostname -I | awk '{print $2}'):3000           grafana (admin/foobar)
http://$(hostname -I | awk '{print $2}'):9090           prometheus
http://$(hostname -I | awk '{print $2}'):9093           alertmanager
http://$(hostname -I | awk '{print $2}'):8500/ui/       consul
http://$(hostname -I | awk '{print $2}'):8080			cadvisor
http://$(hostname -I | awk '{print $2}'):9323/metrics   full set of metrics exposed by docker engine
EOF