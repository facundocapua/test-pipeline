#!/bin/bash
TEAM_NAME=$1
REPO_NAME=$2

BODY=$(cat << EOF
{
    "scm": "git",
    "project": {
        "key": "${SERVICE_NAME}"
    }
}
EOF
)

RESULT=$(curl -s -H "Content-Type: application/json" \
    -X POST \
    -d "${BODY}" \
    --user ${USERNAME}:${PASSWORD} \
    https://api.bitbucket.org/2.0/repositories/${TEAM_NAME}/${REPO_NAME} | jq .)


#Create develop branch
curl -X POST \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -vv --user ${USERNAME}:${PASSWORD} \
    "https://bitbucket.org/branch/create" \
    -s -d 'repository=${TEAM_NAME}%2F${REPO_NAME}&from_branch=master&branch_name=develop'

exit 0