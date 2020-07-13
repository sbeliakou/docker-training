# Lean VM

## Creating Lean VM Dockerfile

We just need sshd running in VM and user credentials
```dockerfile
FROM centos:7

RUN yum install -y systemd openssh-server && systemctl enable sshd
RUN useradd devops && echo devops | passwd devops --stdin

EXPOSE 22
ENTRYPOINT ["/usr/sbin/init"]
```

## Creating Stack file

```yaml
version: "2.3"

services:
  centosvm:
    build:
      context: .
      dockerfile: CentOS.SSHD.Dockerfile
    scale: 1
    volumes:
     - /sys/fs/cgroup
    cap_add:
     - SYS_ADMIN
```

## Oprations

### Create Lean Stack
```bash
$ docker-compose up -d
Creating network "leanvm_default" with the default driver
Creating leanvm_centosvm_1 ... done
```

### Checking the Stack
```bash
$ docker-compose ps
      Name             Command       State   Ports
---------------------------------------------------
leanvm_centosvm_1   /usr/sbin/init   Up      22/tcp
```

### Scaling VMs
```bash
$ docker-compose up -d --scale centosvm=5
Starting leanvm_centosvm_1 ... done
Creating leanvm_centosvm_2 ... done
Creating leanvm_centosvm_3 ... done
Creating leanvm_centosvm_4 ... done
Creating leanvm_centosvm_5 ... done
```

### Checking the Stack
```bash
$ docker-compose ps
      Name             Command       State   Ports
---------------------------------------------------
leanvm_centosvm_1   /usr/sbin/init   Up      22/tcp
leanvm_centosvm_2   /usr/sbin/init   Up      22/tcp
leanvm_centosvm_3   /usr/sbin/init   Up      22/tcp
leanvm_centosvm_4   /usr/sbin/init   Up      22/tcp
leanvm_centosvm_5   /usr/sbin/init   Up      22/tcp
```

### Getting Lean VMs IP Addresses
```bash
$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q)
172.24.0.2
172.24.0.5
172.24.0.6
172.24.0.4
172.24.0.3
```
