# LXQ

LXQ is automation project for LXD

`lxq init`

* Enables UFW
* Updates the Host
*

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
* Look into using bitnami as app source
* Add Wildcard Support for letsencrypt
* Add DNS Support (Needed for Wildcard Support)
* configure auto updates for ubuntu 18.04
  https://help.ubuntu.com/lts/serverguide/automatic-updates.html.en

### Future Ideas
* Setup a Centralized Log Container
* WebGUI
