FROM ubuntu:14.04

RUN apt-get update && \
  apt-cache search rubygems && \
  apt-get -y install ruby ruby-dev rubygems-integration make gcc git && \
  gem install fpm --no-rdoc --no-ri

ADD run.sh /root/

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root
CMD bash /root/run.sh

