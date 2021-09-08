#!/bin/bash

apt-get update
apt-get install iproute2 -y
echo "`ip route | awk '/default/ { print $3 }'`    docker.host.internal              " >> /etc/hosts
