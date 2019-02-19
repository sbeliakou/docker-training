## Using Tools in Containers

### Objectives:
- To have utility packed with all necessary dependencies in one reusable form.

### Build
```bash
$ docker build -t ansible:2.7.7 --build-arg ANSIBLE_VERSION=2.7.7 -f ansible.Dockerfile .
...
Successfully tagged ansible:2.7.7
```
```bash
$ docker build -t ansible:2.6.6 --build-arg ANSIBLE_VERSION=2.6.6 -f ansible.Dockerfile .
...
Successfully tagged ansible:2.6.6
```

### Run
```bash
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) ansible:2.6.6 playbook.yml
$ docker run --rm -v $(pwd):$(pwd) -w $(pwd) ansible:2.7.7 playbook.yml
```

### Make It User Friendly
```bash
$ alias a266='docker run --rm -v $(pwd):$(pwd) -w $(pwd) ansible:2.6.6'
$ alias a277='docker run --rm -v $(pwd):$(pwd) -w $(pwd) ansible:2.7.7'

$ a266
ansible-playbook 2.6.6
  config file = None
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible-playbook
  python version = 2.7.15 (default, Jan 24 2019, 16:32:39) [GCC 8.2.0]

$ a277
ansible-playbook 2.7.7
  config file = None
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/site-packages/ansible
  executable location = /usr/bin/ansible-playbook
  python version = 2.7.15 (default, Jan 24 2019, 16:32:39) [GCC 8.2.0]

$ a266 playbook.yml
$ a277 playbook.yml
```
