# LXQ

* Setups LXD and creates a container with NGINX as a reverse proxy.
* Uses certbot to get Let's Encrypt certificates for each app
* Allows you to easily install apps nextcloud, rocketchat, etc.
* All apps are HTTPS

## Install

First, get the script and make it executable :

`curl -O https://raw.githubusercontent.com/aaronstuder/lxq/master/setup.sh`

`chmod +x setup.sh`

Then run it :

`./setup.sh`

## Available Apps

* Nextcloud
* Rocket.Chat
