#!/bin/bash
echo "Allowing SSH and Enabling Firewall..."
ufw allow ssh
ufw --force enable
echo "Updating System..."
apt-get update
apt-get upgrade -y
echo "Installing Packages..."
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections
apt-get install zfsutils-linux iptables-persistent curl wget -y
echo "Removing LXD Packages..."
apt-get remove --purge lxd lxd-client liblxc1 lxcfs -y
apt-get autoremove -y
echo "Installing snapd..."
apt-get install snapd -y
echo "Installing LXD via Snap..."
snap install lxd
echo "Updating PATH..."
export PATH=$PATH:/snap/bin
echo "Configuing LXD..."
  cat <<EOF | lxd init --preseed
config: {}
networks:
- config:
    ipv4.address: auto
    ipv4.nat: "true"
    ipv6.address: none
  description: ""
  managed: false
  name: lxdbr0
  type: ""
storage_pools:
- config:
    size: 20GB
  description: ""
  name: default
  driver: zfs
profiles:
- config: {}
  description: ""
  devices:
    eth0:
      name: eth0
      nictype: bridged
      parent: lxdbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
cluster: null
EOF
echo LXD Setup Complete!
echo
n=nginx
echo "Creating Container [$n]"
lxc launch ubuntu:18.04 $n
echo "Getting IP Address"
sleep 5s
IP=$(lxc list "nginx" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}')
echo "IP Address is $IP"
echo "Updating Container..."
sleep 5s
lxc exec $n -- apt-get update
lxc exec $n -- apt-get upgrade -y
echo "Adding certbot repository..."
lxc exec $n -- add-apt-repository ppa:certbot/certbot -y
lxc exec $n -- apt-get update
echo "Installing Packages..."
lxc exec $n -- apt-get install nginx software-properties-common python-certbot-nginx -y
echo

echo "Getting your public IP address..."
PUBLIC_IP=`curl ifconfig.me`
echo
echo "Your Public IP is $PUBLIC_IP"
echo
echo "Updating iptables to Forward 80/443 to nginx Container"
echo
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 80 -j DNAT --to-destination $IP:80
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 443 -j DNAT --to-destination $IP:443
netfilter-persistent save
echo
echo "Here are your current PREROUTING Rules"
iptables -t nat -L PREROUTING
echo "Setup Complete!"
echo
