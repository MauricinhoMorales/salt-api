#!/bin/bash

# Define variables
API_URL="http://$SALT_MASTER_HOST:8000"
USERNAME=$SALT_MASTER_USER
PASSWORD=$SALT_MASTER_PASSWORD
EAUTH="auto"

# Obtain auth token
TOKEN=$(curl -sSk "$API_URL/login" \
  -d "username=$USERNAME" \
  -d "password=$PASSWORD" \
  -d "eauth=$EAUTH" | jq -r '.return[0].token')

if [ -z "$TOKEN" ]; then
  echo "Error: Failed to obtain auth token."
  exit 1
fi

# Execute command and capture response
RESPONSE=$(curl -sSk "$API_URL" \
  -H "X-Auth-Token: $TOKEN" \
  -d "client=runner" \
  -d "fun=state.orchestrate" \
  -d "arg=orchestrate.orchestrate_ci" \
  -d 'arg=pillar={"targets":"CoreCluster1 or CoreCluster12"}')

if [ -z "$RESPONSE" ]; then
  echo "Error: Empty response from API."
  exit 1
fi

echo $RESPONSE