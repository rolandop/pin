pipeline {    
    agent any
    environment {
        REGISTRY = "harbor.101si.ar/pin"
        RESULT_NAME = "voting_result"
        RESULT_VERSION = "1.3"
        VOTE_NAME = "voting_vote"
        VOTE_VERSION = "1.3"
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
		sh 'docker login harbor.101si.ar --username=$HARBOR_LOGIN_USR --password=$HARBOR_LOGIN_PSW'
                
                sh "echo push result"
                sh 'docker push $REGISTRY/$RESULT_NAME:$RESULT_VERSION' 
                
		sh "echo push vote"
                sh 'docker push $REGISTRY/$VOTE_NAME:$VOTE_VERSION' 

                sh "echo push worker"
                sh 'docker push $REGISTRY/$WORKER_NAME:$WORKER_VERSION' 
            }           
        }
        stage('Deploy') {
            agent {
                docker {
                    image "ubuntu_ioc:2.0"
                    args '-u root:root'
                    reuseNode true
                }
            }
            environment {                
                AWS_ACCESS_KEY_ID = "${env.AWS_ID_USR}"
                AWS_SECRET_ACCESS_KEY = "${env.AWS_ID_PSW}"
                AWS_REGION = "us-east-1"
            }
            steps {
                sh 'echo Deployment'
                dir("k8s"){
                    sh "pwd"
                    sh "echo Actualiza las versiones de las imàgenes"

                    sh ("sed -i -- 's/VAR_VOTE_VERSION/${VOTE_VERSION}/g' deployments/vote-deployment.yaml")
                    sh ("sed -i -- 's/VAR_RESULT_VERSION/${RESULT_VERSION}/g' deployments/result-deployment.yaml")
                    sh ("sed -i -- 's/VAR_WORKER_VERSION/${WORKER_VERSION}/g' deployments/worker-deployment.yaml")

                    sh 'echo Deployment'
                    sh 'kubectl apply -f deployments/ -n pin-g1'

                    sh 'echo Servicios'
                    sh 'kubectl apply -f services/ -n pin-g1'

                    sh 'echo Ingress'
                    sh 'kubectl apply -f ingress/ -n pin-g1'
                }
            }            
        }
     }
 }
