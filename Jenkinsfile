pipeline {
    agent any

    environment {
        BITBUCKET_USERNAME = credentials('BITBUCKET_USERNAME')
        BITBUCKET_PASSWORD = credentials('BITBUCKET_PASSWORD')
        BITBUCKET_TEAM = 'fcapuateam'
    }

    parameters {
        string(name:'SERVICE', defaultValue:'test_service', description:'The name of the service')
    }

    stages {
        stage('Build') {
            steps {
                sh "./create-project.sh ${params.SERVICE}"
            }
        }
    }
}