import com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition

def dropdown(name)
    {
        def com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition test = 
            new com.cwctravel.hudson.plugins.extended_choice_parameter.ExtendedChoiceParameterDefinition(
            name,
            "PT_MULTI_SELECT",
            "web,api,dbe",  // displayed selection values
            null,//project name
            null,null,null,
            null,// bindings
            null,
            null, // propertykey
            "B", //default value
            null,null,null,
            null, //default bindings
            null,null,
            null, //descriptionPropertyValue
            null,null,null,null,null,null,
            null,// javascript file
            null, // javascript
            false, // save json param to file
            false, // quote
            5, // visible item count
            null,
            "," // separator
        )
        return test
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
        dropdown('COMPONENTS_CHOICE')
    }

    stages {
        stage('SCR') {
            stages{
                stage('Test'){
                    sh "echo ${params.COMPONENTS_CHOICE}"
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