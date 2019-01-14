REPO_NAME=$1
SERVICE_NAME=$2
REPO_FOLDER=./repo/${REPO_NAME}

if [[ "${IS_BITBUCKET_SERVER}" = "true" ]]
then
    REPO_URL=ources.devel.redbull.com/scm/${SERVICE_NAME}/${REPO_NAME}.git
else
    REPO_URL=bitbucket.org/${BITBUCKET_TEAM}/${REPO_NAME}.git
fi

rm -rf ${REPO_FOLDER}
git clone https://${BITBUCKET_USERNAME}:${BITBUCKET_PASSWORD}@${REPO_URL} ${REPO_FOLDER}

if [[ ! -d ${REPO_FOLDER} ]]
then
    echo "The repository can not be cloned! Exiting now..."
    exit 1
fi

cd ${REPO_FOLDER}

git config user.email GIT_NAME
git config user.name GIT_EMAIL

FOLDERS=(DEP CMT LMP MON APP)
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