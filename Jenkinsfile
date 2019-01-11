#!/usr/bin/env groovy
import com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition



node
{
    def componentsAvailable = [
        'ADM':'adm',
        'API':'api',
        'APP':'app',
        'DBE':'dbe',
        'DOM':'dom',
        'ETL':'etl',
        'FIL':'fil',
        'IDX':'idx',
        'IOS':'ios',
        'ISE':'ise',
        'WEB':'web'
    ]

    def componentsChoice
    List optionValues = []
    List optionLabels = [] 

    componentsAvailable.each{ k, v -> 
        optionLabels << k
        optionValues << v
    }

    componentsChoice = new ExtendedChoiceParameterDefinition("COMPONENTS", 
        "PT_CHECKBOX", 
        optionValues.join(','), 
        "project name",
        "", 
        "",
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        optionLabels.join(','), 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        "", 
        false,
        false, 
        9999, 
        "Select the components that are part of the service", 
        "|") 

    List params = []
    List props = []

    params << componentsChoice

    props << parameters(params)
    properties(props)
}

pipeline {
    agent any

    environment {
        BITBUCKET_USERNAME = credentials('BITBUCKET_USERNAME')
        BITBUCKET_PASSWORD = credentials('BITBUCKET_PASSWORD')
        BITBUCKET_TEAM = 'fcapuateam'
        GIT_NAME = 'Facundo Capua'
        GIT_EMAIL = 'fcapua@onica.com'
    }

    parameters {
        string(name:'SERVICE', defaultValue:'test_service', description:'The name of the service')
    }

    stages {
        stage('SCR') {
            stages{
                stage('Project'){
                    steps {
                        sh "./create-project.sh ${params.SERVICE}"
                    }
                }

                stage('Repo'){
                    steps {
                        sh "./create-repo.sh ${params.SERVICE} \"${params.COMPONENTS}\""
                    }
                }
            } 
        }
    }
}