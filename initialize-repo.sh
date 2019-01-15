#!/bin/bash
REPO_NAME=$1
SERVICE_NAME=$2
REPO_FOLDER=./repo/${REPO_NAME}

RETRIES=10

check_repo_status() {
    REPO=$1
    git ls-remote ${REPO} >/dev/null 2>/dev/null
    STATUS=$?

    echo ${STATUS}
    return ${STATUS}
}

if [[ "${IS_BITBUCKET_SERVER}" = "true" ]]
then
    REPO_URL=sources.devel.redbull.com/scm/${SERVICE_NAME}/${REPO_NAME}.git
else
    REPO_URL=bitbucket.org/${BITBUCKET_TEAM}/${REPO_NAME}.git
fi

rm -rf ${REPO_FOLDER}

STATUS=$( check_repo_status ${NOT_WORKING_REPO} )

while [ ${STATUS} -ne 0 ] && [ $RETRIES -gt 0 ]
do
    echo "Repository not found, retrying (${RETRIES})..."
    sleep 1
    STATUS=$( check_repo_status ${WORKING_REPO} )
    RETRIES=$(( ${RETRIES} - 1 ))
done

if [ ${STATUS} -ne 0 ]
then
    echo "Repository not found!"
    exit 1
fi

git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD}@${REPO_URL} ${REPO_FOLDER}

if [[ ! -d ${REPO_FOLDER} ]]
then
    echo "The repository can not be cloned! Exiting now..."
    exit 1
fi

cd ${REPO_FOLDER}

git config user.email GIT_NAME
git config user.name GIT_EMAIL

FOLDERS=(_DEP _LMP _MON)
for FOLDER in ${FOLDERS[*]}
do 
    mkdir ./${FOLDER}
    touch ./${FOLDER}/.gitkeep
done

git add .
git commit -m "Initial Commit"
git checkout -b develop
git push origin --all

cd ../../