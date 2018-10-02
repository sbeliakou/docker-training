# Building myhttpd image

## Building ways:
```
$ docker build .
$ docker tag "<< image_id >>" myhttpd
$ docker tag "<< image_id >>" myhttpd:latest
$ docker tag "<< image_id >>" myhttpd:1.0
```

```
$ docker build -t myhttpd:1.0 .
```

## Providing multiple tags
```
$ docker build -t sbeliakou/myhttpd:1.0 -t myhttpd:1.0 -t myhttpd .

$ docker tag "<< image_id >>" myhttpd:1.0 
$ docker tag "<< image_id >>" sbeliakou/myhttpd:1.0
```

## Run Docker Image
```
$ docker run -d -P "<< image_id >>"
$ docker run -d -P myhttpd
$ docker run -d -P myhttpd:1.0
$ docker run -d -P sbeliakou/myhttpd:1.0

$ docker run -d -p 80:80 myhttpd:1.0
```

Checking Container (Service)
```
$ curl localhost
my httpd container

$ curl -IL localhost
HTTP/1.1 200 OK
Date: Tue, 02 Oct 2018 17:57:33 GMT
Server: Apache/2.4.6 (CentOS)
Last-Modified: Tue, 02 Oct 2018 17:43:16 GMT
ETag: "13-5774274e0f500"
Accept-Ranges: bytes
Content-Length: 19
Content-Type: text/html; charset=UTF-8
```