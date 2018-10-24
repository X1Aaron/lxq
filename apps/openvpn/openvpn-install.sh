#!/bin/bash
c=openvpn
echo "Creating Container [$c]"
lxc launch ubuntu:18.04 $c
echo "Getting IP Address"
sleep 5s
IP=$(lxc list "$c" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}')
echo "IP Address is $IP"
echo "Updating Container..."
sleep 5s
lxc exec $c -- apt-get update
lxc exec $c -- apt-get upgrade -y

echo "Installing OpenVPN..."
lxc exec $c -- wget https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh
lxc exec $c -- chmod +x openvpn-install.sh
lxc exec $c -- sh -c "./openvpn-install.sh"
echo

echo "Getting your public IP address..."
PUBLIC_IP=`curl ifconfig.me`
echo
echo "Your Public IP is $PUBLIC_IP"
echo
echo "Updating iptables to Forward 1194/udp to $c Container"
echo
iptables -t nat -I PREROUTING -i eth0 -p UDP -d $PUBLIC_IP --dport 1194 -j DNAT --to-destination $IP:1194
netfilter-persistent save
echo
echo "Here are your current PREROUTING Rules"
iptables -t nat -L PREROUTING
echo "Setup Complete!"
echo
