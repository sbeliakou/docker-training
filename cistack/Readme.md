# CI Stack

## Services:

[docker-compose file](docker-compose.yml)

- Jenkins (jenkins/jenkins:lts), port 8080
- Nexus (sonatype/nexus3), port 8081

## Operations

```bash
# Create stack
$ docker-compose up -d

# Check Services
$ docker-compose ps
      Name                     Command               State                 Ports
----------------------------------------------------------------------------------------------
cistack_jenkins_1   /sbin/tini -- /usr/local/b ...   Up      50000/tcp, 0.0.0.0:8080->8080/tcp
cistack_nexus_1     sh -c ${SONATYPE_DIR}/star ...   Up      0.0.0.0:8081->8081/tcp

# Destroy Stack
$ docker-compose down
Stopping cistack_nexus_1   ... done
Stopping cistack_jenkins_1 ... done
Removing cistack_nexus_1   ... done
Removing cistack_jenkins_1 ... done
Removing network cistack_default

# Clean Up Volumes
$ docker-compose down --volume
Removing volume cistack_jenkins_data
Removing volume cistack_nexus_data
```