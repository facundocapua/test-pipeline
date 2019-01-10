pipeline {
    agent any

    environment {
        BITBUCKET_USERNAME = credentials('BITBUCKET_USERNAME')
        BITBUCKET_PASSWORD = credentials('BITBUCKET_PASSWORD')
        BITBUCKET_TEAM = 'fcapuateam'
    }

    stages {
        stage('SCR') {
            input {
                message "Please provide the services parameters"
                parameters {
                    string(name:'SERVICE', defaultValue:'test_service', description:'The name of the service')
                    string(name:'COMPONENTS', defaultValue:'web|db|api', description:'The list of components')
                }
            }

            stages{
                stage('Project'){
                    steps {
                        sh "./create-project.sh ${params.SERVICE}"
                    }
                }

                stage('Repo'){
                    steps {
                        sh "./create-repo.sh ${params.SERVICE} ${params.COMPONENTS}"
                    }
                }
            } 
        }
    }
}