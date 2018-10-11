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
echo
echo -n "What is your Domain Name?"
read domain_name
echo
echo Domain Name is $domain_name
echo
echo "Installing acme.sh..."
curl https://get.acme.sh | sh
export PATH=$PATH:~/.acme.sh/
echo "Installing Certs..."
acme.sh  --issue -d '*.$domain_name'  --dns dns_cf



