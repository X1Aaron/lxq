# LXQ

* Setups LXD and creates a container with NGINX as a reverse proxy.
* Uses certbot to get Let's Encrypt certificates for each app
* Allows you to easily install apps nextcloud, rocketchat, etc.
* All apps are HTTPS

## Install

One Line: `wget https://raw.githubusercontent.com/aaronstuder/lxq/master/setup.sh -O - | sudo bash`

or
1. `git clone https://github.com/aaronstuder/lxq.git /opt/lxq`
2. `chmod +x /opt/lxq/setup.sh`
3. `/opt/lxq/setup.sh`

## Available Apps

* Nextcloud
* Rocket.Chat


## TODO
Look into using bitnami as app source
