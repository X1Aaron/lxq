
#!/bin/bash
echo "Enter your FQDN [Fully Qualified Domain Name]"
read FQDN

c=nextcloud

echo
echo "Creating Container $c..."
lxc launch ubuntu:18.04 $c
echo "Getting IP Address"
IP=`lxc list "$c" -c 4 | awk '!/IPV4/{ if ( $2 != "" ) print $2}'`
IP Address is $IP
echo "Updating Container..."
sleep 3s
lxc exec $c -- apt-get update
lxc exec $c -- apt-get upgrade -y
echo "Installing $c"
lxc exec $c -- snap install $c
echo "Gererating Certificate"

echo "Configuring nginx..."
lxc exec nginx -- wget -nc https://raw.githubusercontent.com/aaronstuder/lxd/master/conf/nextcloud.conf -P /etc/nginx/conf.d/
lxc exec nginx -- systemctl reload nginx
echo "Waiting 15 Seconds..."
sleep 15s
echo Done!

cat > nextcloud.conf <<EOF

server {
        client_max_body_size 40M;
        listen 443 ssl;
        server_name nextcloud.lxd1.net;
        ssl          on;
        ssl_certificate /etc/letsencrypt/live/lxd1.net/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/lxd1.net/privkey.pem;

        location / {
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header Host $http_host;
                proxy_set_header X-NginX-Proxy true;
                proxy_pass http://10.0.0.10:80;
                proxy_redirect off;
        }
}

EOF
