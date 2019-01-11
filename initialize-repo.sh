REPO_NAME=$1
REPO_FOLDER=./repo/${REPO_NAME}

rm -rf ${REPO_FOLDER}
git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD}@bitbucket.org/${BITBUCKET_TEAM}/${REPO_NAME}.git ${REPO_FOLDER}

cd ${REPO_FOLDER}

git config user.email GIT_NAME
git config user.name GIT_EMAIL

FOLDERS=(TF CMT LOG MON APP)
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