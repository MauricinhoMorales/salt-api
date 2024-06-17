#!/bin/bash

# Define variables
API_URL="http://3.130.220.130:8000"
USERNAME="koshee"
PASSWORD="koshee"
EAUTH="auto"

# Obtain auth token
TOKEN=$(curl -sSk $API_URL/login -d username=$USERNAME -d password=$PASSWORD -d eauth=$EAUTH | jq -r '.return[0].token')

# Execute a command
RESPONSE=$(curl -sSk $API_URL -H "X-Auth-Token: $TOKEN" -d client='local' -d tgt='koshee-syndic-master' -d fun='state.apply' -d arg='states.events.file_create' | jq .)

# Display response
echo $RESPONSE