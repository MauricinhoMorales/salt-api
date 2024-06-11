#!/bin/bash

# Define variables
API_URL="http://192.168.0.113:8000"
USERNAME="saltuser"
PASSWORD="pan"
EAUTH="pam"

# Obtain auth token
TOKEN=$(curl -sSk $API_URL/login -d username=$USERNAME -d password=$PASSWORD -d eauth=$EAUTH | jq -r '.return[0].token')

# Execute a command
RESPONSE=$(curl -sSk $API_URL -H "X-Auth-Token: $TOKEN" -d client='local' -d tgt='*' -d fun='state.apply' -d arg='states.events.file_create')

# Display response
echo $RESPONSE