FROM centos:7

VOLUME ["/sys/fs/cgroup"]

CMD ["/usr/lib/systemd/systemd"]
