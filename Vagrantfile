# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

_config = YAML.load(File.open(File.join(File.dirname(__FILE__), "/yaml/vagrantconfig.yaml"), File::RDONLY).read)

CONF = _config

Vagrant::Config.run do |config|
	
	config.vm.define :shipyard do |shipyard_config|
		shipyard_config.vm.box = "ubuntu-server"
		shipyard_config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
		shipyard_config.vm.host_name = "shipyard.local"
		shipyard_config.vm.network :hostonly, "192.168.1.2"

		#sets up librarian puppet to be used to install dependencies as well as installs git
		shipyard_config.vm.provision :shell, :path => "shell/prereqs.sh", :args => "puppet/shipyard/librarian"

		#provisions the host using puppet
		shipyard_config.vm.provision :puppet do |shipyard_puppet|
			shipyard_puppet.manifests_path = "puppet/shipyard/manifests"
			shipyard_puppet.manifest_file  = "site.pp"
		end

		#starting up the docker containers running the shipyard infrastructure
		shipyard_config.vm.provision :docker do |shipyard_docker|
			shipyard_docker.run "shipyard/deploy", cmd: "setup", args: "-i -t -v /var/run/docker.sock:/docker.sock"			
		end

		#this makes sure shipyard is up and running before we move on to the docker host
		shipyard_config.vm.provision :shell, :path => "shell/shipyard/foundry.sh"
	end

	config.vm.define :docker do |docker_config|
		docker_config.vm.box = "ubuntu-server"
		docker_config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210.box"
		docker_config.vm.host_name = "docker.local"
		docker_config.vm.network :hostonly, "192.168.1.4"

		#sets up librarian puppet to be used to install dependencies as well as installs git
		docker_config.vm.provision :shell, :path => "shell/prereqs.sh", :args => "puppet/docker/librarian"

		#provisions the host using puppet
		docker_config.vm.provision :puppet do |docker_puppet|
			docker_puppet.manifests_path = "puppet/docker/manifests"
			docker_puppet.manifest_file  = "site.pp"
		end

		#register this docker instance with the shipyard
		docker_config.vm.provision :shell, :path => "shell/docker/agent-install.sh"

		#installing prereqs for docker respository 
		docker_config.vm.provision :shell, :path => "shell/docker/repo-prereqs.sh"

		#starting up a private docker respository 
		docker_config.vm.provision :shell, :path => "shell/docker/repo-install.sh"	
	end
end
