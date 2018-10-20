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
IP=$(lxc list "$c" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}')
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
echo "Downloading .conf file..."
wget --quiet -nc https://raw.githubusercontent.com/aaronstuder/lxq/master/apps/nextcloud/nextcloud.conf
sed -i "s/<<domain_name>>/$domain_name/g" nextcloud.conf
sed -i "s/<<IP>>/$IP/g" nextcloud.conf
echo
echo "Pushing .conf file to container..."
lxc file push nextcloud.conf nginx/etc/nginx/conf.d/
echo "Restarting nginx..."
lxc exec nginx -- systemctl reload nginx
echo
echo "Generating Certificates..."
lxc exec nginx -- certbot --nginx -n --email aaronstuder@gmail.com --agree-tos --domains $domain_name --redirect
echo
echo "Waiting 15 Seconds..."
sleep 15s
echo Done!

