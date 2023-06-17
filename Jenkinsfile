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

        stage('Terraform') {
            agent {
                docker {
                    image 'ubuntu:'
                    args '-u root:root'
                    reuseNode true
                }                
            }
            steps {

                sh "apt-get update && sudo apt-get install -y gnupg software-properties-common"
                sh '''
                    wget -O- https://apt.releases.hashicorp.com/gpg | \
                        gpg --dearmor | \
                        sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
                ''' 
                sh '''
                    gpg --no-default-keyring \
                        --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
                        --fingerprint

                '''

                sh '''
                    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
                    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
                    sudo tee /etc/apt/sources.list.d/hashicorp.list

                '''

                sh "terraform -help plan"
            }
        }

     }
 }
