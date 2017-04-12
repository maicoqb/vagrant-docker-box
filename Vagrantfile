# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'yaml'

currDir = File.expand_path( File.dirname(__FILE__) )
configFile = File.expand_path( currDir + "/config.yaml" )

settings = []

if File.exist? configFile then
	settings = YAML::load( File.read( configFile ) )
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define settings["name"] ||= "docker-host"
  config.vm.hostname = settings["hostname"] ||= "docker-host"
  config.vm.network "private_network", ip: settings["ip"] ||= "192.168.33.10"

  # Configure VirtualBox VM
  config.vm.provider "virtualbox" do |vb|
    vb.name = settings["vm"]["name"] ||= settings["name"] ||= "docker-host"
    vb.customize ["modifyvm", :id, "--memory", settings["vm"]["memory"] ||= "1024"]
    vb.customize ["modifyvm", :id, "--cpus", settings["vm"]["cpus"] ||= "1"]
	end

  # Configure ports from settings
  if settings.has_key?("ports")
    settings["ports"].each do |port|
      config.vm.network "forwarded_port", guest: port["guest"], host: port["host"], auto_correct: true
    end
  end

  # Configure synced_folders from settings 
	if settings.has_key?("folders")
    settings["folders"].each do |folder|
      config.vm.synced_folder folder["from"], folder["to"]
    end
  end

  # Provision scripts from settings
	if settings.has_key?("scripts")
    settings["scripts"].each do |script|
      script = File.expand_path(script)
      if File.exist? script then
        config.vm.provision "shell", path: script
		  end
    end
  end
  
  # Provision scripts from settings
	if settings.has_key?("always-script")
    settings["always-script"].each do |script|
      script = File.expand_path(script)
      if File.exist? script then
        config.vm.provision "shell", path: script, run: 'always'
		  end
    end
  end

  # Disable vagrant default synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

end
