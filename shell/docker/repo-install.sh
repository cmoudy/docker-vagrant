#!/bin/sh

#clone in the docker-registry repository from github
git clone https://github.com/dotcloud/docker-registry.git /opt/docker-registry

cd /opt/docker-registry

#copy over the config file
cp /opt/docker-registry/config/config_sample.yml /opt/docker-registry/config/config.yml

#install everything
pip install -r requirements.txt

#create log directory
mkdir -p /var/log/docker-registry

#copy the upstart conf file to /etc/init
cp /vagrant/template/docker-registry.conf /etc/init/docker-registry.conf

#allowing the execution of the registry
chmod +x /opt/docker-registry/wsgi.py

#start up the registry running on port 5000
service docker-registry start


