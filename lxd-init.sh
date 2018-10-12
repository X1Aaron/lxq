#!/bin/bash
#add a check here to make sure LXD isn't installed already.
PUBLIC_IP=`curl ifconfig.me`
echo
echo Your Public IP is $PUBLIC_IP
echo
echo "Setuping Up Firewall"
#ufw enable ssh
#ufw --force enable
echo Updating...
apt-get update
apt-get upgrade -y
echo "Remove LXD Packages"
apt remove --purge lxd lxd-client liblxc1 lxcfs -y
apt-get autoremove
echo "Install snapd"
apt install snapd -y
echo "Install LXD via Snap"
snap install lxd
echo "Updating PATH"
export PATH=$PATH:/snap/bin
echo "Configuing LXD"
  cat <<EOF | lxd init --preseed
config: {}
networks:
- config:
    ipv4.address: 10.0.0.1/24
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
echo Done!
