#!/bin/bash
SERVICE_NAME=$1
COMPONENTS=$(echo $2 | tr "|" "\n")

mkdir ./repo

for i in $COMPONENTS
do
    REPO_NAME="${SERVICE_NAME}_${i}"
    echo "Creating repo ${REPO_NAME}"

    if [[ "${IS_BITBUCKET_SERVER}" = "true" ]]
    then
        BITBUCKET_ENDPOINT="https://${BITBUCKET_SERVER_URL}/rest/api/1.0/projects/${SERVICE_NAME}/repos"
        CREATE_REPO_REQUEST=$(cat << EOF
{
    "name": "${REPO_NAME}",
    "scmId": "git",
    "forkable": true
}
EOF
)
    else
        BITBUCKET_ENDPOINT="https://api.bitbucket.org/2.0/repositories/${BITBUCKET_TEAM}/${REPO_NAME}"
        CREATE_REPO_REQUEST=$(cat << EOF
{
    "scm": "git",
    "project": {
        "key": "${SERVICE_NAME}"
    }
}
EOF
)
    fi
   
    RESULT=$(curl -s -H "Content-Type: application/json" \
        -X POST \
        -d "${CREATE_REPO_REQUEST}" \
        --user ${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD} \
        ${BITBUCKET_ENDPOINT} | jq .)

    echo ${RESULT}

    sleep 2
    
    ./initialize-repo.sh ${REPO_NAME} ${SERVICE_NAME}
done 
exit 0