## Exposing Docker TCP Socket with TLS

### Documentation
- https://docs.docker.com/engine/security/https/

### Server Side Configuration

1 Creating Certs Directory
```bash
$ mkdir -p /etc/docker/certs.d/
```

2 Generating CA Certificates
```bash
# generate CA private key --> ca-key.pem
$ openssl genrsa -aes256 -passout pass:passphrase -out ca-key.pem 4096

# generate CA public key
$ openssl req -new -x509 -sha256 -days 365 -passin pass:passphrase \
  -subj "/C=BY/ST=Minsk/L=Minsk/O=Organization/OU=Org Unit/CN=docker.playpit.net" \
  -key ca-key.pem \
  -out ca.pem

# Setting Permissions
$ chmod -v 0444 ca.pem
$ chmod -v 0400 ca-key.pem key.pem 
```

3 Generating Server Cerificates
```bash
# create a server key
openssl genrsa -out server-key.pem 4096

# create a certificate signing request (CSR)
$ openssl req -new -sha256 -subj "/CN=docker.playpit.net" -key server-key.pem -out server.csr

# sign the public key with our CA
$ echo 'subjectAltName = DNS:docker.playpit.net,IP:0.0.0.0' > extfile.cnf
$ echo 'extendedKeyUsage = serverAuth' >> extfile.cnf

$ openssl x509 -req -sha256 -days 365 \
   -CA ca.pem -CAkey ca-key.pem -CAcreateserial \
   -extfile extfile.cnf \
   -in server.csr \
   -out server-cert.pem

# Setting Permissions
$ chmod -v 0400 server-key.pem
$ chmod -v 0444 server-cert.pem

# Remove files
rm server.csr extfile.cnf
```

4 Configuring Docker Daemon
```bash
$ cat /etc/docker/daemon.json
{
  "hosts": [
    "unix:///var/run/docker.sock",
    "tcp://0.0.0.0:2376"
  ],
 
  "tls": true,
  "tlsverify": true,
  "tlscacert": "/etc/docker/certs.d/ca.pem",
  "tlscert": "/etc/docker/certs.d/server-cert.pem",
  "tlskey": "/etc/docker/certs.d/server-key.pem"
}

# Make sure /usr/lib/systemd/system/docker.service has no "-H" option in ExecStart cmd

$ systemctl restart docker
```

5 Creating Client Certificates
```bash
# create a client key
$ openssl genrsa -out key.pem 4096

# create a certificate signing request (CSR)
$ openssl req  -new -subj '/CN=client' -key key.pem -out client.csr

# sign client certificate with CA
$ echo 'extendedKeyUsage = clientAuth' > extfile-client.cnf
$ openssl x509 -req -sha256 -days 365 \
  -CA ca.pem -CAkey ca-key.pem -CAcreateserial \
  -extfile extfile-client.cnf \
  -in client.csr -out key.pem 

# Remove files
rm client.csr extfile-client.cnf
```

### Client Side Configuration

1 Configuring Docker Client
```bash
$ mkdir -p ~/.docker/docker.playpit.net

$ cp cert.pem ca.pem key.pem ~/.docker/docker.playpit.net/
$ chmod 0444 ca.pem cert.pem
$ chmod 0400 key.pem

$ tree -p ~/.docker/docker.playpit.net/
~/.docker/docker.playpit.net/
    ├── [-r--r--r--]  ca.pem
    ├── [-r--r--r--]  cert.pem
    └── [-r--------]  key.pem

$ docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem -H=docker.playpit.net:2376 info

$ export DOCKER_CERT_PATH=~/.docker/docker.playpit.net/
$ export DOCKER_TLS_VERIFY=1
$ export DOCKER_HOST=tcp://docker.playpit.net:2376

$ docker info
```

### Local Engineering Environment

```bash
$ vagrant up
==> default: Machine 'default' has a post `vagrant up` message. This is a message
==> default: from the creator of the Vagrantfile, and not from Vagrant itself:
==> default:
==> default:     It's done!
==> default:
==> default:     export DOCKER_CERT_PATH=$(pwd)/client
==> default:     export DOCKER_TLS_VERIFY=1
==> default:     export DOCKER_HOST=tcp://docker-host:2376
==> default:
==> default:     docker info
```