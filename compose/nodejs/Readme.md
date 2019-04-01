## Using Docker-Compose for Build Purposes

### Build
```bash
$ docker-compose up -f docker-compose-with-gitclone.yml
$ docker-compose up -f docker-compose-in-workdir.yml
```

### Cleanup
```bash
$ docker-compose down -f docker-compose-with-gitclone.yml --volumes
$ docker-compose down -f docker-compose-in-workdir.yml --volumes
```
