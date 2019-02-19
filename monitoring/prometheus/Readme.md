### Prometheus stack

### Prerequisites
Add the following to enable docker daemon to expose its metrics

```bash
$ cat /etc/docker/daemon.json
{
    "metrics-addr" : "0.0.0.0:9323",
    "experimental" : true
}
```

### Available Services:

Locate the tools under the following URLs
	- http://<< host_ip/name >>:3000			grafana (admin/foobar)
	- http://<< host_ip/name >>:9090			prometheus
	- http://<< host_ip/name >>:9093			alertmanager
	- http://<< host_ip/name >>:8500/ui/ 	consul
	- http://<< host_ip/name >>:8080			cadvisor
	- http://<< host_ip/name >>:9323/metrics full set of metrics exposed by docker engine
