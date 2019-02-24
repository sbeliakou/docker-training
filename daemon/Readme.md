## Useful Dockerd Configuration Options

### Root directory of persistent Docker state
```json
{
    "data-root": "/var/lib/docker"
}
```

### Storage Driver
```json
{
    "storage-driver": "devicemapper",
    "storage-opts": [
        "dm.thinpooldev=/dev/mapper/thin-pool",
        "dm.use_deferred_deletion=true",
        "dm.use_deferred_removal=true"
      ]
}
```

### CGroup Driver
```json
{
    "exec-opts": [
        "native.cgroupdriver=systemd"
    ]
}
```

### Log Driver
```json
{
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "10m",
        "max-files":"5",
        "labels": "some_label",
        "env": "os,customer"
    }
}
```

### Internal Registries
```json
{
    "insecure-registries": ["10.10.10.100"]
}
```

### Default Networks
```json
{
    "default-address-pools": [
        {
            "base":"172.80.0.0/16", "size":24
        },
        {
            "base":"172.90.0.0/16", "size":24
        }
    ]
}
```

### Exposing API by TCP
```json
{
    "hosts": [
        "unix:///var/run/docker.sock",
        "tcp://127.0.0.1:2375",
        "10.10.10.2"
    ]
}
```
```
$ sudo dockerd -H unix:///var/run/docker.sock -H tcp://127.0.0.1:2375 -H tcp://10.10.10.2
```


### Dockerd Metrics

```json
{
    "metrics-addr" : "0.0.0.0:9323",
    "experimental" : true
}
```

### Keep containers alive during daemon downtime
! Incompatible with SWARM Mode
```json
{
    "live-restore": true
}
```
