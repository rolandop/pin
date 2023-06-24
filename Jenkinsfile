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
                sh "echo push result"
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$RESULT_NAME:$RESULT_VERSION' 

                sh "echo push vote"
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$VOTE_NAME:$VOTE_VERSION' 

                sh "echo push worker"
                sh 'docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW'
                sh 'docker push $REGISTRY/$WORKER_NAME:$WORKER_VERSION' 
            }
           
        }


        stage('Infraestructura') {
            
            agent {
                docker {
                    image "rolandop/ubuntu_ioc"
                    args '-u root:root'
                    reuseNode true
                }
            }

            environment {                
                AWS_ACCESS_KEY_ID = "${env.r}"
                AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
                AWS_REGION = "us-east-1"
            }
             
             
            steps {
                sh "apt update && apt upgrade -y"                
                sh "aws --version"
                sh "aws sts get-caller-identity"
                
                dir ("tf"){
                    sh "terraform --version"
                    sh "echo terraform init"

                    sh "terraform init"
                    sh "echo terraform plan"

                    sh "terraform plan"
                    sh "echo terraform apply"
                    
                    sh "terraform apply -auto-approve" 
                }
            }
                   
        }

     }
 }
