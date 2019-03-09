# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # CentOS 7, 20 GB HDD, nothing extra
  config.vm.box = "sbeliakou/centos"

  # VM IP Address in the Private Network
  config.vm.network :private_network, ip: "192.168.56.15"

  # Host's hostname
  config.vm.hostname = "docker-host"

  config.ssh.insert_key = false
  config.vm.provider "virtualbox" do |vb|
    # Virtualbox VM name
    vb.name = "docker-host"

    # no matter how much CPU is used in the VM, 
    # no more than 50% would be used on your own host machine
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "30"]
    
    # RAM provided to VM
    vb.memory = "2048"
  end

  # Docker Installation Steps
  config.vm.provision "shell", inline: <<-SHELL
    # jq, net-tools required for troubleshooting needs
    yum install -y yum-utils jq net-tools

    # actual Docker Installation
    yum-config-manager --add-repo \
      https://download.docker.com/linux/centos/docker-ce.repo
    yum-config-manager --enable docker-ce-edge
    yum install -y docker-ce

    systemctl enable docker
    systemctl start docker

    # The docker daemon binds to a Unix socket /var/run/docker.sock which is owned by root:docker
    # Non-root user just needs to be added to the docker group.
    usermod -aG docker vagrant
  SHELL
end
