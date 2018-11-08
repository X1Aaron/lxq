curl -O https://raw.githubusercontent.com/Angristan/openvpn-install/master/openvpn-install.sh
lxc file push openvpn-install.sh $1/tmp/
rm openvpn-install.sh
lxc exec $1 -- chmod +x /tmp/openvpn-install.sh
lxc exec $1 -- /tmp/openvpn-install.sh