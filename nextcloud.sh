#!/bin/bash
c=nextcloud
#echo "Enter the Domain Name you would like to use for $c"
#read domain_name



echo
echo "Creating Container $c..."
lxc launch ubuntu:18.04 $c
echo "Getting IP Address..."
sleep 5s
IP=$(lxc list "nginx" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}')
echo "IP Address is $IP"
echo "Updating Container..."
sleep 3s
lxc exec $c -- apt-get update
lxc exec $c -- apt-get upgrade -y
echo "Installing $c"
lxc exec $c -- snap install $c
echo "Configuring nginx..."
wget https://raw.githubusercontent.com/aaronstuder/lxd/master/nextcloud.sh
sed -i 's/<<domain_name>>/$domain_name/g' nextcloud.conf
sed -i 's/<<IP>>/$IP/g' nextcloud.conf
lxc file push nextcloud.conf nginx/etc/nginx/conf.d/
echo "Restarting nginx..."
lxc exec nginx -- systemctl reload nginx
echo "Gererating Certificate..."
echo "Waiting 15 Seconds..."
sleep 15s
echo Done!

