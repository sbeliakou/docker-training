apt-get update
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    git \
    gnupg-agent \
    software-properties-common
    
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io
apt-get install -y --allow-downgrades docker-ce-cli=5:19.03.8~3-0~ubuntu-bionic

curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
