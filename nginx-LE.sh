apt-get update
apt-get install software-properties-common
add-apt-repository ppa:certbot/certbot
apt-get update
apt-get install certbot
certbot certonly --manual --preferred-challenges dns -d *.lxd1.net --agree-tos
