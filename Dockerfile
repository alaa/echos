# Setup echos client on a Docker container.

FROM ashchan/ruby-2.1.5
MAINTAINER Alaa Qutaish

USER root

WORKDIR /root
RUN apt-get update
RUN apt-get -y install curl wget git unzip htop strace
RUN apt-get -y install nagios-plugins
RUN apt-get -y install rabbitmq-server
CMD rabbitmq-server start

WORKDIR /tmp
RUN wget https://github.com/alaa/echos/archive/master.zip
RUN unzip master.zip
RUN mv echos-master ~/echos

WORKDIR /root/echos
RUN bundle install
