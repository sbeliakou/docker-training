# Prometheus stack


## Add the following to enable docker daemon to expose its metrics

```bash
$ cat /etc/docker/daemon.json
{
    "metrics-addr" : "0.0.0.0:9323",
    "experimental" : true
}
```

## Clone the repo

```bash
$ git clone https://github.com/shreben/prometheus.git
```

## Enter the directory and run the stack

```bash
$ cd prometheus/
$ docker-compose up -d
```

## Locate the tools under the following URLs

	- http://localhost:3000			grafana (admin/foobar)
	- http://localhost:9090			prometheus
	- http://localhost:9093			alertmanager
	- http://localhost:8500/ui/ 	consul
	- http://localhost:8080			cadvisor
	- http://localhost:9323/metrics full set of metrics exposed by docker engine