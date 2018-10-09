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
echo "Updating iptables"
echo
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 80 -j DNAT --to-destination 10.0.0.2:80
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 443 -j DNAT --to-destination 10.0.0.2:443
echo
echo "Here are your current PREROUTING Rules"
iptables -t nat -L PREROUTING
echo
echo "##############################"
echo "          Complete            "
echo "##############################"
echo
