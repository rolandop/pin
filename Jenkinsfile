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
                    image "rolandop/ubuntu_ioc"
                    args '-u root:root'
                    reuseNode true
                }
            }
             
            steps {
                sh "apt update"
                withCredentials([string(credentialsId: 'AWS-Auth-PIN', variable: 'secret')]) {
                    script {
                        def creds = readJSON text: secret
                        env.AWS_ACCESS_KEY_ID = creds['accessKeyId']
                        env.AWS_SECRET_ACCESS_KEY = creds['secretAccessKey']
                        env.AWS_REGION = 'us-east-1' // or whatever
                    }
                    sh "aws --version"
                    sh "aws sts get-caller-identity" // or whatever
                }
                sh "terraform --version"
                dir ("terraform"){
                    sh "echo terraform init"
                    sh "terraform init"
                }
            }
                   
        }

     }
 }
