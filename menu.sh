#!/bin/bash

function install-lxd {
wget https://raw.githubusercontent.com/aaronstuder/lxd/master/lxd-init.sh && chmod a+x lxd-init.sh && ./lxd-init.sh
}

function nginx {
wget https://raw.githubusercontent.com/aaronstuder/lxd/master/nginx.sh && chmod a+x nginx.sh && ./nginx.sh
}


function thirdroutine {
 echo "running adams function"
}

whiptail --title "LXD Setup Scripts" --checklist --separate-output "Choose:" 20 78 15 \
"Install LXD" "[Installs LXD and Configures blah blah blah]" off \
"Install Nginx" "Installs Nginx with SSL and Configures a Port Forward to it" off \
"Adam" "" off 2>results

while read choice
do
        case $choice in
                "Install LXD") install-lxd
                ;;
                "Install Nginx") nginx
                ;;
                Adam) thirdroutine
                ;;
                *)
                ;;
        esac
done < results
