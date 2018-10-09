#!/bin/bash
echo "Creating Container nginx..."
lxc launch ubuntu:18.04 nginx
echo "Setting IP Address"
lxc network attach lxdbr0 nginx eth0 eth0
lxc config device set nginx eth0 ipv4.address 10.0.0.2
lxc restart nginx
echo "Updating Container..."
lxc-attach -n nginx -- apt update && apt upgrade -y
echo "Installing nginx"
lxc-attach -n nginx -- apt install nginx -y
echo "##########"
echo "Complete"
echo "##########"
