# LXQ

LXQ is an automation platform for LXD

# System Requirements

* LXQ is tested on Ubuntu 18.04 and is designed to be used on a fresh Ubuntu 18.04 VM.
* All containers are Ubuntu 18.04
* Processor, RAM, and Hard drive requirements are based on what/how many apps you install and usage of those apps.

# Commands

`lxq update`

* Updates LXQ

`lxq init`

* Enables UFW (SSH Only)
* Updates the Host
* Removes LXD Packages and Installs LXD via Snap
* Setup and Configures LXD
* Setup and Configures a nginx container to serve as a reverse proxy
* Forwards ports 80/443 from the host to the nginx container

`lxq install <appname> <domain_name>`

* Creates and updates a container
* Installs the app inside the contianer
* Generates a .conf file, pushs it to the nginx container and reloads nginx *(if needed)*
* Automatically forwards any needed ports to your app *(if needed)*

`lxq remove <appname>`

* Removes Container
* Deletes .conf from the nginx container
* Reloads Nginx
* Updates Firewall Rules

`lxq backup <appname>`

* Creates a backup of the app
* Run without a appname, it backups all containers.

`lxq conf <option>`
* purge - delete the LXQ conf file
* edit - opens the conf file to edit it
* run without an option shows you the LXQ configuation

`lxq wildcard <dns>`
* Setups Wildcard Cert
* Only supports Cloudflare for now.
*Want another DNS provider? Open a Issue.*


## Install

First, get the script and make it executable :

`wget https://raw.githubusercontent.com/aaronstuder/lxq/master/installer/setup.sh`

`chmod +x setup.sh`

Then run it :

`./setup.sh`

## Available Apps

* Nextcloud
* Rocket.Chat
* BookStack
