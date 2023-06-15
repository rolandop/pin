pipeline {    
    agent any
    environment {
        REGISTRY = "rolandop"
        VOTING_NAME = "voting_result"
        VOTING_VERSION = "1.1"
        DOCKER_HUB_LOGIN = credentials('dockerhub-rolandop')
    }
    stages {        
        
        stage('voting-result-build'){
            steps {
                dir("result"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$VOTING_NAME:$VOTING_VERSION .'  
                }                          
            }            
        }

        stage('voting-result-docker-push') {
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$VOTING_NAME:$VOTING_VERSION' 
            }
        }

     }
 }
