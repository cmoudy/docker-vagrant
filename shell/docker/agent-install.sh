#!/bin/sh

SHIPYARD_VERSION=v0.2.4
SHIPYARD_HOST=192.168.1.2
SHIPYARD_PORT=8000

#enabling the listening for shipyard
echo 'DOCKER_OPTS = \"-H tcp://127.0.0.1:4243 -H unix:///var/run/docker.sock\"' >> /etc/default/docker

#allowing firewall for connection with shipyard agent
ufw allow 4243/tcp

service docker restart

#grab the shipyard agent 
curl https://github.com/shipyard/shipyard-agent/releases/download/${SHIPYARD_VERSION}/shipyard-agent -L -o /usr/local/bin/shipyard-agent

#allowing the execution of the agent
chmod +x /usr/local/bin/shipyard-agent

#copy the upstart conf file to /etc/init
cp /vagrant/template/shipyard-agent.conf /etc/init/shipyard-agent.conf

cd /usr/local/bin

#add agent file to /etc/default
REGISTER_OUT=`./shipyard-agent -url http://${SHIPYARD_HOST}:${SHIPYARD_PORT} -register 2>&1`

#This will read the output of register and then put the key into the file 
#I wasn't smart enough to assign the variable looking for the key with this command: "${REGISTER_OUT##*Key:}".
echo -n "-url http://${SHIPYARD_HOST}:${SHIPYARD_PORT} -key " > /etc/default/shipyard-agent
echo "${REGISTER_OUT##*Key:}" | tr -d ' ' >> /etc/default/shipyard-agent

service shipyard-agent start 


