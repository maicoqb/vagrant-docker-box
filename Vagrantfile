# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "docker-host"

	config.vm.provision :shell, path: "provision.sh"

	config.vm.network :forwarded_port, guest: 80, host: 4567
	
	config.vm.provider "virutalbox" do |v|
		v.name = "docker-host"
	end
	
end
