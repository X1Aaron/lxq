#!/bin/bash
PUBLIC_IP=`curl ifconfig.me`
echo
echo Your Public IP is $PUBLIC_IP
echo
echo "Creating Container nginx..."
lxc launch ubuntu:18.04 nginx
echo "Setting IP Address"
lxc network attach lxdbr0 nginx eth0 eth0
lxc config device set nginx eth0 ipv4.address 10.0.0.2
lxc restart nginx
echo "Updating Container..."
lxc exec nginx -- apt update && apt upgrade -y
echo "Installing nginx"
lxc exec nginx -- apt install nginx -y
echo
echo "##############################"
echo "          Complete            "
echo "##############################"
echo
