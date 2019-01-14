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

if [[ "${IS_BITBUCKET_SERVER}" = "true" ]]
then
    BITBUCKET_ENDPOINT="https://${BITBUCKET_SERVER_URL}/rest/api/1.0/projects"
else
    BITBUCKET_ENDPOINT="https://api.bitbucket.org/2.0/teams/${BITBUCKET_TEAM}/projects/"
fi

RESULT=$(curl -s -H "Content-Type: application/json" \
       -X POST \
       -d "${BODY}" \
       --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
       ${BITBUCKET_ENDPOINT})

if [ $(echo ${RESULT} | jq -r '.type') = "error" ]; then
    echo "There was an error creating the project"
    echo ${RESULT}
    exit 1
fi

exit 0
