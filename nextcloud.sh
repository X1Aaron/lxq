
#!/bin/bash
#domain_name=lxd1.net
#echo "Domain Name = $domain_name

c=nextcloud

echo
echo "Creating Container nextcloud..."
lxc launch ubuntu:18.04 $c
echo "Getting IP Address"
lxc list "$c" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}'
echo "Updating Container..."
sleep 3s
lxc exec $c -- apt-get update
lxc exec $c -- apt-get upgrade -y
echo "Installing $c"
lxc exec $c -- snap install $c
echo "Configuring nginx..."
lxc exec nginx -- wget -nc https://raw.githubusercontent.com/aaronstuder/lxd/master/conf/nextcloud.conf -P /etc/nginx/conf.d/
lxc exec nginx -- systemctl reload nginx
echo "Waiting 15 Seconds..."
sleep 15s
echo Done!
