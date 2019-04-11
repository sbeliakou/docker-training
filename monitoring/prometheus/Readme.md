### Prometheus stack

### Architecture
![Architecture](.pics/architecture.png)


### Prerequisites
Add the following to enable docker daemon to expose its metrics

```bash
$ cat /etc/docker/daemon.json
{
    "metrics-addr" : "0.0.0.0:9323",
    "experimental" : true
}
```

### Stack Rolling Out

```
$ docker-compose up -d
```
