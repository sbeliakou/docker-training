# Testing CMD vs ENTRYPOINT

## Building Images

```
$ docker build -f ping:1.0 -t ping:1.0 .
$ docker build -f ping:2.0 -t ping:2.0 .
$ docker build -f ping:3.0 -t ping:3.0 .
```

## Test Cases

```
$ docker run ping:1.0
PING epam.com (174.128.60.201): 56 data bytes
64 bytes from 174.128.60.201: seq=0 ttl=61 time=286.267 ms

--- epam.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 286.267/286.267/286.267 ms
```
```
$ docker run ping:1.0 --help
BusyBox v1.29.3 (2018-10-01 22:37:18 UTC) multi-call binary.

Usage: ping [OPTIONS] HOST

Send ICMP ECHO_REQUEST packets to network hosts

	-4,-6		Force IP or IPv6 name resolution
	-c CNT		Send only CNT pings
	-s SIZE		Send SIZE data bytes in packets (default 56)
	-A		Ping as soon as reply is recevied
	-t TTL		Set TTL
	-I IFACE/IP	Source interface or IP address
	-W SEC		Seconds to wait for the first response (default 10)
			(after all -c CNT packets are sent)
	-w SEC		Seconds until ping exits (default:infinite)
			(can exit earlier with -c CNT)
	-q		Quiet, only display output at start
			and when finished
	-p HEXBYTE	Pattern to use for payload
```
```
$ docker run ping:1.0 google.com
PING google.com (216.58.214.110): 56 data bytes
64 bytes from 216.58.214.110: seq=0 ttl=61 time=80.917 ms
64 bytes from 216.58.214.110: seq=1 ttl=61 time=31.955 ms
64 bytes from 216.58.214.110: seq=2 ttl=61 time=32.028 ms
64 bytes from 216.58.214.110: seq=3 ttl=61 time=31.794 ms
^C
--- google.com ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max = 31.794/44.173/80.917 ms
```
```
$ docker run ping:1.0 -c1 google.com
PING google.com (216.58.207.78): 56 data bytes
64 bytes from 216.58.207.78: seq=0 ttl=61 time=168.870 ms

--- google.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 168.870/168.870/168.870 ms
```
```
$ docker run ping:2.0
BusyBox v1.29.3 (2018-10-01 22:37:18 UTC) multi-call binary.

Usage: ping [OPTIONS] HOST

Send ICMP ECHO_REQUEST packets to network hosts

	-4,-6		Force IP or IPv6 name resolution
	-c CNT		Send only CNT pings
	-s SIZE		Send SIZE data bytes in packets (default 56)
	-A		Ping as soon as reply is recevied
	-t TTL		Set TTL
	-I IFACE/IP	Source interface or IP address
	-W SEC		Seconds to wait for the first response (default 10)
			(after all -c CNT packets are sent)
	-w SEC		Seconds until ping exits (default:infinite)
			(can exit earlier with -c CNT)
	-q		Quiet, only display output at start
			and when finished
	-p HEXBYTE	Pattern to use for payload
```
```
$ docker run ping:2.0 --help
BusyBox v1.29.3 (2018-10-01 22:37:18 UTC) multi-call binary.

Usage: ping [OPTIONS] HOST

Send ICMP ECHO_REQUEST packets to network hosts

	-4,-6		Force IP or IPv6 name resolution
	-c CNT		Send only CNT pings
	-s SIZE		Send SIZE data bytes in packets (default 56)
	-A		Ping as soon as reply is recevied
	-t TTL		Set TTL
	-I IFACE/IP	Source interface or IP address
	-W SEC		Seconds to wait for the first response (default 10)
			(after all -c CNT packets are sent)
	-w SEC		Seconds until ping exits (default:infinite)
			(can exit earlier with -c CNT)
	-q		Quiet, only display output at start
			and when finished
	-p HEXBYTE	Pattern to use for payload
```
```
$ docker run ping:2.0 google.com
PING google.com (216.58.210.14): 56 data bytes
64 bytes from 216.58.210.14: seq=0 ttl=61 time=250.523 ms
64 bytes from 216.58.210.14: seq=2 ttl=61 time=32.634 ms
64 bytes from 216.58.210.14: seq=3 ttl=61 time=37.480 ms
64 bytes from 216.58.210.14: seq=4 ttl=61 time=35.603 ms
^C
--- google.com ping statistics ---
5 packets transmitted, 4 packets received, 20% packet loss
round-trip min/avg/max = 32.634/89.060/250.523 ms
```
```
$ docker run ping:2.0 -c1 google.com
PING google.com (172.217.22.46): 56 data bytes
64 bytes from 172.217.22.46: seq=0 ttl=61 time=40.591 ms

--- google.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 40.591/40.591/40.591 ms
```
```
$ docker run ping:3.0
PING epam.com (174.128.60.201): 56 data bytes
64 bytes from 174.128.60.201: seq=0 ttl=61 time=210.266 ms

--- epam.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 210.266/210.266/210.266 ms
```
```
$ docker run ping:3.0 ping -c1 google.com
PING google.com (216.58.207.78): 56 data bytes
64 bytes from 216.58.207.78: seq=0 ttl=61 time=39.164 ms

--- google.com ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max = 39.164/39.164/39.164 ms
```