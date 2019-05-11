## Objectives

- To have a set of VM-like Containers for testing VM-based provisioning scripts
- Replacement to Vagrant based Local Engineering Environment

## CentOS

### CLI
```
$ docker run -it --rm centos readlink /usr/sbin/init
../lib/systemd/systemd

$ docker run -d -v /sys/fs/cgroup --cap-add sys_admin centos /usr/lib/systemd/systemd
$ docker exec $(docker ps -ql) systemctl status
● b57a46803c38
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Sat 2019-05-11 17:21:44 UTC; 10s ago
   CGroup: /docker/b57a46803c380626f3209fc705019761fab5768dd8bda549b4a3373794636b2a
           ├─ 1 /usr/lib/systemd/systemd --switched-root --system
           ├─37 systemctl status
           └─system.slice
             ├─dbus.service
             │ └─28 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
             ├─systemd-logind.service
             │ └─29 /usr/lib/systemd/systemd-logind
             └─systemd-journald.service
               └─18 /usr/lib/systemd/systemd-journald
```

## Ubuntu

```
$ docker build -f Ubuntu.Systemd.Dockerfile -t sbeliakou/ubuntu-systemd:18.04 .
$ docker run -d --cap-add sys_admin -v /sys/fs/cgroup:/sys/fs/cgroup:ro sbeliakou/ubuntu-systemd:18.04
$ docker exec $(docker ps -ql) systemctl status
● b4da6494f545
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Sat 2019-05-11 17:27:25 UTC; 2s ago
   CGroup: /docker/b4da6494f545c21ba31fbc9eff50236ced03a2ca5a0b9f118f2b273b1fd0bbd9
           ├─35 systemctl status
           ├─init.scope
           │ └─1 /lib/systemd/systemd
           └─system.slice
             ├─dbus.service
             │ └─29 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
             ├─networkd-dispatcher.service
             │ └─28 /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
             ├─systemd-logind.service
             │ └─30 /lib/systemd/systemd-logind
             ├─systemd-resolved.service
             │ └─25 /lib/systemd/systemd-resolved
             └─systemd-journald.service
               └─20 /lib/systemd/systemd-journald
```

## docker-compose.yml

```yaml
version: "3"

services:
  centosvm-vanilla:
    image: centos:7
    command:
      - /usr/lib/systemd/systemd
    volumes:
      - /sys/fs/cgroup
    cap_add:
      - SYS_ADMIN

  centosvm:
    build:
      context: .
      dockerfile: CentOS.Systemd.Dockerfile
    image: sbeliakou/centos-systemd:7
    cap_add:
      - SYS_ADMIN

  ubuntuvm:
    build:
      context: .
      dockerfile: Ubuntu.Systemd.Dockerfile
    image: sbeliakou/ubuntu-systemd:18.04
    volumes:
      - /sys/fs/cgroup:/sys/fs/cgroup:ro
    cap_add:
      - SYS_ADMIN
```
