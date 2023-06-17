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

        

        stage('Terraform') {
            agent {
                docker {
                    image 'ubuntu' 
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
