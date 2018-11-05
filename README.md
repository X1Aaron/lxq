# LXQ

LXQ is automation project for LXD

# System Requirements

* LXQ is tested on Ubuntu 18.04 and is designed to be used on a fresh Ubuntu 18.04 VM.
* All containers are Ubuntu 18.04
* Processor, RAM, and Hard drive requirements are based on what apps you install.

`lxq update`

* Updates LXQ

`lxq init`

* Enables UFW
* Updates the Host
* Removes LXD Packages and Installs LXD via Snap
* Setup and Configures LXD
* Setup and Configures a nginx container to serve as a reverse proxy
* Forwards ports 80/443 from the host to the nginx container

`lxd install <appname>`

* Creates and updates a container
* Installs the app inside the contianer
* Generates a .conf file, pushs it to the nginx container and reloads nginx *(if needed)*
* Automatically forwards any needed ports to your app *(if needed)*

`lxd remove <appname>`

* Removes Container
* Deletes .conf from the nginx container
* Reloads Nginx
* Updates Firewall Rules

`lxd backup <appname>`

* Creates a backup of the app
* Run without a appname, it backups all containers.


## Install

One Line: `wget https://raw.githubusercontent.com/aaronstuder/lxq/master/setup.sh -O - | sudo bash`

or
1. `git clone https://github.com/aaronstuder/lxq.git /opt/lxq`
2. `chmod +x /opt/lxq/setup.sh`
3. `/opt/lxq/setup.sh`

## Available Apps

* Nextcloud
* Rocket.Chat
