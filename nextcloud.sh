#!/bin/bash
c=nextcloud
echo "Enter Domain Name:"
read domain_name
echo
echo "Creating Container $c..."
lxc launch ubuntu:18.04 $c
echo
echo "Getting IP Address..."
sleep 5s
IP=$(lxc list "nginx" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}')
echo
echo "IP Address is $IP"
echo
echo "Updating Container..."
sleep 3s
lxc exec $c -- apt-get update
lxc exec $c -- apt-get upgrade -y
echo
echo "Installing $c"
lxc exec $c -- snap install $c
echo
echo "Creating .conf file..."
wget -nc https://raw.githubusercontent.com/aaronstuder/lxd/master/conf/nextcloud.conf
sed -i "s/<<domain_name>>/$domain_name/g" nextcloud.conf
sed -i "s/<<IP>>/$IP/g" nextcloud.conf
echo
echo "Pushing .conf file to container..."
lxc file push nextcloud.conf nginx/etc/nginx/conf.d/
echo
echo "Restarting nginx..."
lxc exec nginx -- systemctl reload nginx
echo
echo "Gererating Certificate..."
echo "Waiting 15 Seconds..."
sleep 15s
echo Done!

