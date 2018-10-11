# LXD

## One Liner:

curl -sSL https://raw.githubusercontent.com/aaronstuder/lxd/master/menu.sh | bash

| Container | IP Address | Ports Forwarded to Container |
| ------------- | ------------- | ----- |
| Host      | 10.0.0.1 | N/A |
| nginx     | 10.0.0.2 | 80/TCP 443/TCP |
| openvpn   | 10.0.0.3 | 1194/UDP |
| pihole    | 10.0.0.4 | 53/UDP |
| nextcloud | 10.0.0.5 | None |
| rocketchat| 10.0.0.6 | None |

#To Do
- Make wget only download one file
- Enable firewall working
- Setup Logging
- make scripts only run once
- 
