#!/usr/bin/env groovy
import com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition

def componentsChoice

node
{
    componentsChoice = new ExtendedChoiceParameterDefinition("COMPONENTS_CHOICE", 
        "PT_CHECKBOX", 
        "blue,green,yellow", 
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
        "BLUE,GREEN,YELLOW", 
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
        "multiselect", 
        "|") 

    List params = []
    List props = []

    params << componentsChoice
    //params << Inst2

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
        string(name:'COMPONENTS', defaultValue:'web|db|api', description:'The list of components')
    }

    stages {
        stage('SCR') {
            stages{
                stage('Test'){
                    steps{
                        sh "echo \"${params.COMPONENTS_CHOICE}\""
                    }
                }
                // stage('Project'){
                //     steps {
                //         sh "./create-project.sh ${params.SERVICE}"
                //     }
                // }

                // stage('Repo'){
                //     steps {
                //         sh "./create-repo.sh ${params.SERVICE} \"${params.COMPONENTS}\""
                //     }
                // }
            } 
        }
    }
}