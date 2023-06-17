pipeline {    
    agent any
    environment {
        REGISTRY = "rolandop"
        RESULT_NAME = "voting_result"
        RESULT_VERSION = "1.1"
        VOTE_NAME = "voting_vote"
        VOTE_VERSION = "1.1"
        WORKER_NAME = "voting_worker"
        WORKER_VERSION = "1.1"
        DOCKER_HUB_LOGIN = credentials('dockerhub-rolandop')
    }
    stages {        

        stage('build images'){
            steps {
                dir("result"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$RESULT_NAME:$RESULT_VERSION .'  
                }      
                dir("vote"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$VOTE_NAME:$VOTE_VERSION .'  
                }  
                dir("worker"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$WORKER_NAME:$WORKER_VERSION .'  
                }                    
            }            
        }        
        
        stage('docker-push') {
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$RESULT_NAME:$RESULT_VERSION' 
            }
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$VOTE_NAME:$VOTE_VERSION' 
            }
            steps {
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$WORKER_NAME:$WORKER_VERSION' 
            }
        }

     }
 }
