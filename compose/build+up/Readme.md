# Full Stack Example

## The Stack:

- [Full Stack File](docker-compose.yml)

### Services:
- [Frontend](frontend.Dockerfile): Apache Httpd
- [Backend](backend.Dockerfile): Apache Tomcat + sample.war

## Oprations:

```bash
# Build Images and Spin Up Services
$ docker-compose up -d --build

# Check Services Status
$ docker-compose ps
              Name                     Command           State             Ports
---------------------------------------------------------------------------------------
thestack_backend_1_823662fee265    catalina.sh run    Up (healthy)   8080/tcp
thestack_frontend_1_904f490ba736   httpd-foreground   Up (healthy)   0.0.0.0:80->80/tcp

# Destroy the Stack
$ docker-compose down

# Destroy the Stack and Clean up Volumes
$ docker-compose down --volume
```

## Browse Sample App

[Sample App in the Tomcat Backend](http://localhost/sample/)