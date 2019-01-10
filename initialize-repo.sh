REPO_NAME=$1
REPO_FOLDER=./repo/${REPO_NAME}


git clone https://facundocapua@bitbucket.org/${BITBUCKET_TEAM}/${REPO_NAME}.git ${REPO_FOLDER}

cd ${REPO_FOLDER}

mkdir TF CMT LOG MON APP
git commit -am "Initial Commit"
git checkout -b develop
git push origin --all

cd ../../