docker-vagrant
============

[Vagrant](http://www.vagrantup.com/) Development Environment for Kick-Starting Developing Docker Containers.  

Ever wanted to try Docker and dind't know where to start?

This Vagrant setup will get you going with creating your very own [Docker] (https://www.docker.io/) container images.  Included in the installation are two servers one running [Shipyard] (http://shipyard-project.com/) to visually manage your Docker Environment and the other setup as a [Docker] (https://www.docker.io/) Host including a [Private Docker Registry] (http://blog.docker.io/2013/07/how-to-use-your-own-registry/).  Included in this Kickstart are two sample container images one base [Ubuntu] (http://www.ubuntu.com/) image and a simple [HAProxy] (http://haproxy.1wt.eu/) Image as a basis for getting started.

## Prerequisites
  You must have [Vagrant installed] (https://docs.vagrantup.com/v2/installation/) on you local host machine.

### Quick Start
1. Clone the repo: `git clone git://github.com/cmoudy/docker-vagrant.git`
* Launch Shipyard machine using the command `vagrant up shipyard`.
* Navigate to [Shipyard Server] (http://admin:shipyard@192.168.1.2:8000) ensure it is up and running by logging in using default credentials admin/shipyard.
* Launch Docker Host machine using the command `vagrant up docker`.
* Once the Docker Host machine is up and running you will want to navigate to [Shipyard] (http://192.168.1.2:8000/hosts) Authorize the Host and set the ip of the Docker Host to `192.168.1.4` as it defaults to internal Vagrant IP on setup.

### Mini-Docker Tutorial 
1. SSH into the Docker Host Machine: `vagrant ssh docker`
* Switch to the ubuntu base image folder `cd /vagrant/images/ubuntu-base`
* Build the base image with the following: `sudo docker build -t ubuntu-base:1.0.0 .` 
* Switch over to the included HAProxy example image and build it as well: sudo docker build -t haproxy:1.0.0 .
* Start an HAProxy container using the newly created HAProxy Image: `sudo docker run -i -t -p 9000:9000 haproxy:1.0.0`
* Navigate to your browser to view your [HAProxy] (http://haproxy:haproxy@192.168.1.4:9000) instance is up and running using haproxy/haproxy.  

#### Environment Details
    * Shipyard Server IP = 192.168.1.2
    * Docker Server IP = 192.168.1.4

#### Using local registry on docker server <optional>

This Environment includes a Docker Private registry hosted on the Docker Host Machine running under port 5000. 

Example usages:

	* Tag for local registry import `sudo docker tag ubuntu-base:1.0.0 docker.local:5000/ubuntu-base:1.0.0`

	* Push to local registry <must tag first> `sudo docker push docker.local:5000/ubuntu-base`
