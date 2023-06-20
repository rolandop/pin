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
        AWS_ID = credentials("AWAWS-Auth-PINS_ID")
    }
    stages {        


        stage('IoC') {
            
            agent {
                docker {
                    image "rolandop/ubuntu_ioc"
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
                sh "apt update"                
                sh "aws --version"
                sh "aws sts get-caller-identity" // or whatever
                sh "terraform --version"
                dir ("terraform"){
                    sh "echo terraform init"
                    sh "terraform init"
                }
            }
                   
        }

     }
 }
