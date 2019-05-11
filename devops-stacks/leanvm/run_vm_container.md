## CentOS

### CLI
```
docker run -it --rm centos readlink /usr/sbin/init
../lib/systemd/systemd

docker run -d -v /sys/fs/cgroup --cap-add sys_admin centos /usr/lib/systemd/systemd
b57a46803c380626f3209fc705019761fab5768dd8bda549b4a3373794636b2a

docker exec $(docker ps -ql) systemctl status
● b57a46803c38
    State: running
     Jobs: 0 queued
   Failed: 0 units
    Since: Sat 2019-05-11 14:11:44 UTC; 10s ago
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

### docker-compose.yml

```yaml
version: "3"

services:
  centosvm:
    image: centos
    command:
      - /usr/lib/systemd/systemd
    volumes:
     - /sys/fs/cgroup
    cap_add:
     - SYS_ADMIN
```
