# SWARM Playground

## Spinning up swarm stack
```bash
# From this folder

# Create 2 VMs: Manager (192.168.56.16) + Worker (192.168.56.17)
$ vagrant up

# SSH to Manager Node:
$ vagrant ssh manager

# SSH to Worker Node:
$ vagrant ssh worker
```

## Checking Swarm Stack Status

From outside Manager:
```bash
# docker -H tcp://192.168.56.16:2375 node ls
# OR
$ export DOCKER_HOST=tcp://192.168.56.16:2375
$ docker node ls
ID                            HOSTNAME     STATUS     AVAILABILITY        MANAGER STATUS   ENGINE VERSION
6rjmhyl48mo6fxw0rhuv3ciar *   manager      Ready      Active              Leader           18.06.1-ce
qgzjsa0r9p1pp0ch4egwth5nb     worker       Ready      Active                               18.06.1-ce
```

From Manager (Only):
```bash
$ vagrant ssh manager
$ docker node ls
```

## Deploying Sample Service

Accessing Clustiner from Outside
```bash
$ export DOCKER_HOST=tcp://192.168.56.16:2375
```

Create Service Network
```bash
$ docker network create -d overlay net_echo
q1t1p4ppg3r8r1e3f6hz2h5rr
```

Deploy Application
```bash
#                       SVC Name     SVC NETWORK         No App Instances  Port      App Image
$ docker service create --name echo  --network net_echo  --replicas 2      -p 80:80  sbeliakou/httpd-echo
3chd4vn6e4hnlkngflrrq20hb
overall progress: 2 out of 2 tasks
1/2: running   [==================================================>]
2/2: running   [==================================================>]
verify: Service converged
```

Checking Service Status
```bash
$ docker service ls
ID              NAME      MODE            REPLICAS     IMAGE                         PORTS
3chd4vn6e4hn    echo      replicated      2/2          sbeliakou/httpd-echo:latest   *:80->80/tcp

$ docker service ps echo
ID              NAME      IMAGE                         NODE         DESIRED STATE       CURRENT STATE            ERROR               PORTS
uupdohp2y0uw    echo.1    sbeliakou/httpd-echo:latest   worker       Running             Running 47 seconds ago
o4s0caavnlp7    echo.2    sbeliakou/httpd-echo:latest   manager      Running             Running 48 seconds ago

$ docker service inspect --pretty echo
ID:		3chd4vn6e4hnlkngflrrq20hb
Name:		echo
Service Mode:	Replicated
 Replicas:	2
Placement:
UpdateConfig:
 Parallelism:	1
 On failure:	pause
 Monitoring Period: 5s
 Max failure ratio: 0
 Update order:      stop-first
RollbackConfig:
 Parallelism:	1
 On failure:	pause
 Monitoring Period: 5s
 Max failure ratio: 0
 Rollback order:    stop-first
ContainerSpec:
 Image:		sbeliakou/httpd-echo:latest@sha256:6e5724ce1b630159bfd038e3f27fd5a052890f4a4f8f27d3c1da492be46c7c67
 Init:		false
Resources:
Networks: net_echo
Endpoint Mode:	vip
Ports:
 PublishedPort = 80
  Protocol = tcp
  TargetPort = 80
  PublishMode = ingress
```

Scaling Service
```bash
$ docker service scale echo=5
echo scaled to 5
overall progress: 5 out of 5 tasks
1/5: running   [==================================================>]
2/5: running   [==================================================>]
3/5: running   [==================================================>]
4/5: running   [==================================================>]
5/5: running   [==================================================>]
verify: Service converged
```

Accessing Service (Routing Mesh)
```bash
$ curl 192.168.56.16
Request was processed on e486c9090984
$ curl 192.168.56.17
Request was processed on 998a6a775e33
$ curl 192.168.56.16
Request was processed on 639f96204005
...
```

Removing Service
```bash
$ docker service rm echo
echo
```

## Deploying Sample Stack

Deployment [citools.yml](citools.yml)
```bash
$ docker stack deploy --compose-file citools.yml citools
Creating network citools_default
Creating service citools_nexus
Creating service citools_jenkins
```

Get a list of stacks
```bash
$ docker stack ls
NAME             SERVICES            ORCHESTRATOR
citools          2                   Swarm
```

List the services in the stack
```bash
$ docker stack services citools
ID               NAME                MODE            REPLICAS     IMAGE                    PORTS
p17tr7xz86km     citools_nexus       replicated      1/1          sonatype/nexus3:latest   *:8081->8081/tcp
qkbc7l0oogqr     citools_jenkins     replicated      1/1          jenkins/jenkins:lts      *:80->8080/tcp
```

List the tasks in the stack
```bash
$ docker stack ps citools
ID            NAME               IMAGE                    NODE     DESIRED STATE    CURRENT STATE                ERROR               PORTS
zd96y6bdnyhj  citools_jenkins.1  jenkins/jenkins:lts      worker   Running          Running about a minute ago
c13esgvpt448  citools_nexus.1    sonatype/nexus3:latest   worker   Running          Running about a minute ago
```

Remove the stack
```
$ docker stack rm citools
Removing service citools_jenkins
Removing service citools_nexus
Removing network citools_default
```