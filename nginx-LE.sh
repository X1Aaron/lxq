echo
echo -n "What is your CloudFlare Email?"
read CF_Email
echo
echo CloudFlare Email is $CF_Email
echo
echo -n "What is your CloudFlare API Key?"
read CF_Key
echo
echo CloudFlare Key is $CF_Key
echo
echo "Installing acme.sh..."
curl https://get.acme.sh | sh
echo "Installing Certs..."
acme.sh  --issue -d '*.example.com'  --dns dns_cf

#CF_Key="sdfsdfsdfljlbjkljlkjsdfoiwje"
#CF_Email="xxxx@sss.com"
#acme.sh  --issue -d example.com  -d '*.example.com'  --dns dns_cf
#certbot certonly --manual --preferred-challenges dns -d *.$domain_name
