# Building Tomcat Image. Approaches

## 1. Using Dockerfile

[Dockerfile](tomcat.Dockerfile)
```
$ docker build -t sbeliakou/tomcat:$(date +"%Y-%m-%d-%H-%M-%S") -f tomcat.Dockerfile
```

## 2. Using Packer (Builder `docker`, Provisioner `shell`)

More Details:
- [Installing Packer](https://www.packer.io/intro/getting-started/install.html)
- [Variables](https://www.packer.io/docs/templates/user-variables.html)
- [Builder: `docker`](https://www.packer.io/docs/builders/docker.html)
- [Provisioner: `shell`](https://www.packer.io/docs/provisioners/shell.html)
- [Post-Processor: `docker-tag`](https://www.packer.io/docs/post-processors/docker-tag.html)
- [Post-Processor: `docker-push`](https://www.packer.io/docs/post-processors/docker-push.html)


### 2.1 Using Inline Commands

[Packer Configuration](tomcat_with_inline.json)

```
# Building Image with default settings/variables
$ packer build tomcat_with_inline.json

# Passing Variables in CLI:
$ packer build -var TOMCAT_VERSION=7.0.55 tomcat_with_inline.json
```

### 2.2 Using Installation Script

[Packer Configuration](tomcat_with_script.json)
[Installation Script](tomcat_install.json)

```
# Building Image with default settings/variables
$ packer build tomcat_with_script.json

# Passing Variables in CLI:
$ packer build -var TOMCAT_VERSION=7.0.55 tomcat_with_script.json
```

## 3. Checking Images

```
$ docker run -d -P $(docker images --format "{{.Repository}}:{{.Tag}}" | head -1)

$ curl -sIL 127.0.0.1:$(docker port $(docker ps -lq) | cut -d: -f2)
HTTP/1.1 200 OK
Server: Apache-Coyote/1.1
Content-Type: text/html;charset=ISO-8859-1
Transfer-Encoding: chunked
Date: Thu, 25 Oct 2018 09:04:11 GMT
```

### 3.1 Checking Image History

```
$ docker image history $(docker images --format "{{.Repository}}:{{.Tag}}" | head -1)
```