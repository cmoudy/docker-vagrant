#!/bin/sh

# start supervisord in nodaemon mode
supervisord -n -c /etc/supervisor.conf
