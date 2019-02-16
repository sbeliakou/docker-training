# CPU Restrictions

## CPU period constraint
The default CPU CFS (Completely Fair Scheduler) period is 100ms. We can use `--cpu-period` to set the period of CPUs to limit the container’s CPU usage. And usually `--cpu-period` should work with `--cpu-quota`.

Examples:
```bash
$ docker run -it --cpu-period=50000 --cpu-quota=25000 ubuntu:14.04 /bin/bash
```
If there is 1 CPU, this means the container can get 50% CPU worth of run-time every 50ms.

In addition to use `--cpu-period` and `--cpu-quota` for setting CPU period constraints, it is possible to specify `--cpus` with a float number to achieve the same purpose. For example, if there is 1 CPU, then --cpus=0.5 will achieve the same result as setting `--cpu-period=50000` and `--cpu-quota=25000` (50% CPU).

The default value for `--cpus` is `0.000`, which means there is no limit.

For more information, see the CFS documentation on bandwidth limiting.

## Testing Settings

### Docker-Compose

[docker-compose file](docker-compose.yml)

```yaml
version: "2.2" #  and higher
service:
  service_name:
    cpu_quota: 10000
    cpu_period: 100000
    cpus: 0.15
```

```bash
$ docker-compose up -d
Creating network "cpu-tests_default" with the default driver
Creating cpu010 ... done
Creating cpu015 ... done
```

```
$ docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}"
NAME                CPU %
cpu010              9.56%
cpu015              15.10%
```

### Docker Run

```
$ docker build -t stress .
$ docker run docker run -it -d --cpu-quota=25000 --name cpu0.25 stress
$ docker run docker run -it -d --cpus=0.35 --name cpu0.35 stress
```