#!/bin/bash

apt-get update
apt-get install iproute2 -y
echo "`ip route | awk '/default/ { print $3 }'`    emiserv.fundaciobit.org              " >> /etc/hosts
