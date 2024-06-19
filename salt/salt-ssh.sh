#!/bin/bash

# Define variables
SALT_MASTER_HOST=$SALT_MASTER_HOST
SALT_MASTER_USER=$SALT_MASTER_USER
SSH_PRIVATE_KEY="~/.ssh/ci_key_koshee.pem"

# Define the orchestrate command to be executed on the Salt master
ORCHESTRATE_COMMAND="echo "koshee" | sudo -S salt-run state.orchestrate orchestrate.orchestrate_ci pillar='{\"targets\":\"CoreCluster1 or CoreCluster12\"}'"

# Execute the command via SSH
RESPONSE=$(ssh -i "$SSH_PRIVATE_KEY" "$SALT_MASTER_USER@$SALT_MASTER_HOST" "$ORCHESTRATE_COMMAND")

if [ -z "$RESPONSE" ]; then
  echo "Error: Empty response from SSH command."
  exit 1
fi

echo $RESPONSE