#!/bin/bash
SERVICE_NAME=$1
COMPONENTS=$(echo $2 | tr "|" "\n")

CREATE_REPO_REQUEST=$(cat << EOF
{
    "scm": "git",
    "project": {
        "key": "${SERVICE_NAME}"
    }
}
EOF
)

mkdir ./repo

for i in $COMPONENTS
do
    REPO_NAME="${SERVICE_NAME}_${i}"
    echo "Creating repo ${REPO_NAME}"
   
    RESULT=$(curl -s -H "Content-Type: application/json" \
        -X POST \
        -d "${CREATE_REPO_REQUEST}" \
        --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
        https://api.bitbucket.org/2.0/repositories/${BITBUCKET_TEAM}/${REPO_NAME} | jq .)

    echo ${RESULT}

    sleep 2

    ./initialize-repo.sh ${REPO_NAME}
done 
exit 0