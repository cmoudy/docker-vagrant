# DOCKER-VERSION 0.6.3

FROM ubuntu-base:1.0.0
MAINTAINER cmoudy

#User and group for HAProxy
RUN groupadd haproxy
RUN useradd -r -g haproxy haproxy

#Install HAProxy
RUN apt-get install -y haproxy

# enable HAProxy to be started by the init script.
RUN echo "ENABLED=1" > /etc/default/haproxy

#add the haproxy config file
RUN rm /etc/haproxy/haproxy.cfg
ADD haproxy.cfg /etc/haproxy/

ADD haproxy-supervisord.conf /etc/supervisor/conf.d/

VOLUME ["/etc/haproxy"]

#Expose the haproxy stats port
EXPOSE 9000

#Start HAProxy 
CMD cd /opt && ./start.sh
