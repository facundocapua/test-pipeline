#!/bin/bash
SERVICE_NAME=$1
COMPONENTS=$(echo $2 | tr "|" "\n")

BODY=$(cat << EOF
{
    "scm": "git",
    "project": {
        "key": "${SERVICE_NAME}"
    }
}
EOF
)

for COMPONENT in COMPONENTS
do
    REPO_NAME="${SERVICE_NAME}_${COMPONENT}"
    RESULT=$(curl -s -H "Content-Type: application/json" \
        -X POST \
        -d "${BODY}" \
        --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
        https://api.bitbucket.org/2.0/repositories/${BITBUCKET_TEAM}/${REPO_NAME} | jq .)


    #Create develop branch
    curl -X POST \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -vv --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
        "https://bitbucket.org/branch/create" \
        -s -d 'repository=${BITBUCKET_TEAM}%2F${REPO_NAME}&from_branch=master&branch_name=develop'
done 
exit 0