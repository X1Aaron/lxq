echo
echo "What is your domain name?"
read domain_name
echo
a='*.'
c="$a$domain_name"

echo $c

apt-get update
apt-get install software-properties-common
add-apt-repository ppa:certbot/certbot -y
apt-get update
apt-get install certbot python3-certbot-dns-cloudflare -y
certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/cloudflare.ini  -d $c --agree-tos --manual-public-ip-logging-ok
