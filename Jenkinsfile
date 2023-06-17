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


        stage('IoC') {
            agent {
                docker {
                    image "ubuntu:22.04"
                    args '-u root:root'
                    reuseNode true
                }
            }
             
            steps {
                sh "apt update"

                sh "echo installing AWS CLI"
                sh "apt install -y awscli"
                sh "aws --version"
                
                sh "echo installing terraform"                 
                sh '''                    
                    apt install -y wget
                    apt install -y unzip
                    wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_386.zip
                    unzip -o terraform_1.5.0_linux_386.zip -d /usr/bin/
                    rm terraform_1.5.0_linux_386.zip
                '''
                sh "terraform --version"
                dir ("terraform"){
                    sh "echo terraform init"
                    sh "terraform init"
                }
            }
                   
        }

     }
 }
