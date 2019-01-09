#!/bin/bash
SERVICE_NAME=$1

# Create project
BODY=$(cat << EOF
{
    "name": "${SERVICE_NAME}",
    "key": "${SERVICE_NAME}",
    "description": "A test service",
    "is_private": false
}
EOF
)

RESULT=$(curl -s -H "Content-Type: application/json" \
       -X POST \
       -d "${BODY}" \
       --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
       https://api.bitbucket.org/2.0/teams/${BITBUCKET_TEAM}/projects/)

if [ $(echo ${RESULT} | jq -r '.type') = "error" ]; then
    echo "There was an error creating the project"
    echo ${RESULT}
    #exit 1
fi
