

#!/bin/bash
# Bash Menu Script Example

if [ -d "/snap/bin/" ];
then
LXD_STATUS=Installed
else
LXD_STATUS=NotInstalled
fi

function install_lxc {
    wget https://raw.githubusercontent.com/aaronstuder/lxd/master/lxd-init.sh && chmod a+x lxd-init.sh && ./lxd-init.sh
}

function reinstall_theme {
    echo "Reinstalling theme"
    wget https://raw.githubusercontent.com/aaronstuder/lxd/master/nginx.sh && chmod a+x nginx.sh && ./nginx.sh
}

all_done=0
while (( !all_done )); do
    options=("Install LXD $LXD_STATUS" "Reinstall theme" "Quit")

    echo "Choose an option: "
    select opt in "${options[@]}"; do
        case $REPLY in
            1) install_lxc; break ;;
            2) reinstall_theme; break ;;
            3) all_done=1; break ;;
            *) echo "What's that?" ;;
        esac
    done
done

echo "Bye bye!"
