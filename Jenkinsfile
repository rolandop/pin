pipeline {    
    agent any
    environment {
        REGISTRY = "harbor.101si.ar/pin"
        RESULT_NAME = "voting_result"
        RESULT_VERSION = "1.2"
        VOTE_NAME = "voting_vote"
        VOTE_VERSION = "1.2"
        WORKER_NAME = "voting_worker"
        WORKER_VERSION = "1.2"
        HARBOR_LOGIN = credentials('harbor-rolandop')
        AWS_ID = credentials("AWS-Auth-PIN")
    }
    stages {        

        stage('build images'){
            steps {

                sh "echo build result"
                dir("result"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$RESULT_NAME:$RESULT_VERSION .'  
                }

                sh "echo build vote"
                dir("vote"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$VOTE_NAME:$VOTE_VERSION .'  
                }

                sh "echo build worker"
                dir("worker"){
                    sh "pwd"
				    sh 'docker build -t $REGISTRY/$WORKER_NAME:$WORKER_VERSION .'  
                }                    
            }            
        }
        
        stage('docker-push') {
            steps {
		sh 'echo login a harbor.101si.ar'
		sh 'docker login harbor.101si.ar login --username=$HARBOR_LOGIN_USR --password=$HARBOR_LOGIN_PSW'
                
                sh "echo push result"
                sh 'docker push $REGISTRY/$RESULT_NAME:$RESULT_VERSION' 
                
		sh "echo push vote"
                sh 'docker push $REGISTRY/$VOTE_NAME:$VOTE_VERSION' 

                sh "echo push worker"
                sh 'docker push $REGISTRY/$WORKER_NAME:$WORKER_VERSION' 
            }           
        }
     }
 }
