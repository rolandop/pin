pipeline {    
    agent any
    environment {
        REGISTRY = "rolandop"
        VOTING_NAME = "voting_result"
        DOCKER_HUB_LOGIN = credentials('dockerhub-rolandop')
    }
    stages {        
        stage('voting-result-run-build'){
            
            agent {
                docker {
                    image 'node:alpine'
                    args '-u root:root'
				    reuseNode true
                }
            }         

        }
        stage('voting-result-build'){
            steps {
                dir("result"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$VOTING_NAME:1.0 .'  
                }

                          
            }
        }
     }
 }
