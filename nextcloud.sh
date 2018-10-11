#!/bin/bash
#domain_name=lxd1.net
#echo "Domain Name = $domain_name 
echo
echo "Creating Container nextcloud..."
lxc launch ubuntu:18.04 nextcloud
echo "Setting IP Address"
lxc network attach lxdbr0 nextcloud eth0 eth0
lxc config device set nextcloud eth0 ipv4.address 10.0.0.10
lxc restart nextcloud
echo "Updating Container..."
lxc exec nextcloud -- apt-get update && apt-get upgrade -y
echo "Installing nextcloud"
lxc exec nextcloud -- apt-get install snapd
lxc exec nextcloud -- snap install nextcloud
echo "Setting up Nginx" 
lxc exec nginx -- wget https://raw.githubusercontent.com/aaronstuder/lxd/master/conf/nextcloud.conf -P /etc/nginx/conf.d/
lxd exec nginx -- sed -i 's/$domain_name/lxd1.net/g' /etc/nginx/conf.d/nextcloud.conf
echo Done!
