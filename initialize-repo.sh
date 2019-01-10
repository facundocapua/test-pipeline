REPO_NAME=$1
REPO_FOLDER=./repo/${REPO_NAME}

rm -rf ${REPO_FOLDER}
git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD}@bitbucket.org/${BITBUCKET_TEAM}/${REPO_NAME}.git ${REPO_FOLDER}

cd ${REPO_FOLDER}

git config --global user.email GIT_NAME
git config --global user.name GIT_EMAIL

mkdir ./TF ./CMT ./LOG ./MON ./APP
git commit -am "Initial Commit"
git checkout -b develop
git push origin --all

cd ../../