#!/bin/bash

yum install -y git

cd /tmp
git clone https://github.com/shreben/prometheus.git
cd prometheus/
docker-compose up -d

cat <<EOF
http://localhost:3000           grafana (admin/foobar)
http://localhost:9090           prometheus
http://localhost:9093           alertmanager
http://localhost:8500/ui/       consul
http://localhost:8080			cadvisor
http://localhost:9323/metrics   full set of metrics exposed by docker engine
EOF