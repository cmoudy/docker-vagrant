#!/bin/sh

#install pre-reqs
apt-get -q -y install build-essential python-dev libevent-dev python-pip libssl-dev liblzma-dev libffi-dev

#upgrade pip
pip install --upgrade pip
