# -*- mode: ruby -*-
# vi: set ft=ruby :

# Make sure to have the latest Vagrant installed (>=1.8), e.g., https://releases.hashicorp.com/vagrant/1.8.5/vagrant_1.8.5_x86_64.deb

name = "dukecon-vagrant"
memory = 3072

ip_unique = ENV['VAGRANT_IP_UNIQUE'] || "55"
port_unique = ENV['VAGRANT_PORT_UNIQUE'] || "55"

Vagrant.configure(2) do |config|
  # Generic/Defaults
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = name
  config.vm.synced_folder "cache/apt-archives", "/var/cache/apt/archives"

  config.vm.provider "virtualbox" do |vbox, override|
    vbox.name = name
    vbox.memory = memory
    override.vm.network "private_network", ip: "192.168.50.#{ip_unique}", virtualbox__intnet: true
    # Docker Registry
    override.vm.network "forwarded_port", guest: 5000, host: "#{port_unique}050"
    # Apache
    override.vm.network "forwarded_port", guest: 80, host: "#{port_unique}080"
    # Nexus
    override.vm.network "forwarded_port", guest: 8081, host: "#{port_unique}081"
  end

  config.vm.provider "parallels" do |parallels, override|
    parallels.update_guest_tools = true
    override.vm.box = "parallels/ubuntu-14.04"
    parallels.name = name
    parallels.memory = memory
    override.vm.network "private_network", ip: "10.211.55.#{ip_unique}", virtualbox__intnet: true
  end

  config.vm.provision "shell", path: "puppet/init-puppet-debian.sh"
  config.vm.provision "shell", path: "init-java8-on-trusty.sh"
  config.vm.provision "shell", path: "puppet/init-puppet-docker-base.sh"
  config.vm.provision "shell", path: "puppet/init-apache-debian.sh"
  config.vm.provision "shell", path: "puppet/init-puppet-jenkins.sh"
end
