#!/usr/bin/env groovy
import com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition
import groovy.json.JsonSlurper

node
{
    def componentsUrl = "https://raw.githubusercontent.com/facundocapua/test-pipeline/master/components.json"          
    def componentsObjectRaw = [
        "curl", 
        "-s", 
        "-H", 
        "accept: application/json", 
        "-k", "--url", "${componentsUrl}"].execute().text
    def jsonSlurper = new JsonSlurper()
    def componentsJsonObject = jsonSlurper.parseText(componentsObjectRaw)
    List optionValues = []
    List optionLabels = [] 

    for(item in componentsJsonObject){
        optionLabels << item.name
        optionValues << item.prefix
    } 

    def componentsChoice

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
        IS_BITBUCKET_SERVER = 'false'
        BITBUCKET_SERVER_URL = 'example.com'
    }

    parameters {
        string(name:'SERVICE_NAME', defaultValue:'RBNA.WingTips', description:'This is the name of the BitBucket Project. Project name should begin with organization (ex. RBNA), followed by a period, and Service Name (ex. WingTips). Project Name Example: “RBNA.WingTips”')
    }

    stages {
        stage('SCR') {
            stages{
                stage('Project'){
                    steps {
                        script {
                            env.SERVICE_KEY=params.SERVICE_NAME.toLowerCase().replaceAll(/[^A-Za-z0-9_]/, "_")
                        }
                        
                        sh "./create-project.sh ${params.SERVICE_NAME} ${env.SERVICE_KEY}"
                    }
                }

                stage('Repo'){
                    steps {
                        sh "./create-repo.sh ${env.SERVICE_KEY} \"${params.COMPONENTS}\""
                    }
                }
            } 
        }
    }
}