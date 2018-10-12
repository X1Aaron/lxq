#!/bin/bash
echo What is your email address? [Used for Let’s Encrypt]
read email
echo What is your Cloudflare Email Address?
read cf_email
echo
echo What is your Cloudflare API Key?
read cf_key

cat > cloudflare.ini <<EOF
# Cloudflare API credentials used by Certbot
dns_cloudflare_email = $cf_email
dns_cloudflare_api_key = $cf_key
EOF

PUBLIC_IP=`curl ifconfig.me`
echo
echo "What is your domain name?"
read domain_name
echo
a='*.'
c="$a$domain_name"
n=nginx

echo
echo Your Public IP is $PUBLIC_IP
echo
echo "Allowing SSH and Enabling Firewall..."
ufw allow ssh
ufw --force enable
echo Updating System...
apt-get update
apt-get upgrade -y
echo "Removing LXD Packages..."
apt remove --purge lxd lxd-client liblxc1 lxcfs -y
apt-get autoremove -y
echo "Installing snapd..."
apt install snapd -y
echo "Installing LXD via Snap..."
snap install lxd
echo "Updating PATH..."
export PATH=$PATH:/snap/bin
echo "Configuing LXD..."
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
echo LXD Setup Complete!
echo
echo "Creating Container [$n]"
lxc launch ubuntu:18.04 $n
echo "Setting IP Address"
lxc network attach lxdbr0 $n eth0 eth0
lxc config device set $n eth0 ipv4.address 10.0.0.2
lxc restart $n
echo "Updating Container..."
sleep 3s
lxc exec $n -- apt-get update
lxc exec $n -- apt-get upgrade -y
echo "Adding certbot repository..."
lxc exec $n -- add-apt-repository ppa:certbot/certbot -y
lxc exec $n -- apt-get update
echo "Installing Packages..."
lxc exec $n -- apt-get install nginx software-properties-common certbot python3-certbot-dns-cloudflare -y
echo
echo "Setting Up HTTPS for $domain_name"
lxc file push cloudflare.ini nginx/root/
lxc exec $n -- certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/cloudflare.ini -d $domain_name  -d c$ --agree-tos --noninteractive --manual-public-ip-logging-ok --email $email


echo "Updating iptables to Forward 443 to nginx Container"
echo
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 80 -j DNAT --to-destination 10.0.0.2:80
iptables -t nat -I PREROUTING -i eth0 -p TCP -d $PUBLIC_IP --dport 443 -j DNAT --to-destination 10.0.0.2:443
echo
echo "Here are your current PREROUTING Rules"
iptables -t nat -L PREROUTING
echo "$n Setup Complete!"






