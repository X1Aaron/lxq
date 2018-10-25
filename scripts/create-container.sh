#!/bin/bash

function CREATE_CONTAINER() {
  echo "Creating Container $CONTAINER..."
  lxc launch images:ubuntu/18.04 $CONTAINER
  CONTAINER_LOCAL_IP=$(lxc list -c 4 --format csv | awk '{print $1}')
  echo "IP Address: $CONTAINER_LOCAL_IP"
  echo
  echo "Updating Container..."
  lxc exec $CONTAINER -- apt update && lxc exec $CONTAINER -- apt dist-upgrade -y
  echo "Created and updated container" $CONTAINER 
}
