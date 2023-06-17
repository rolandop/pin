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
                    image 'ubuntu:'
                    args '-u root:root'
                    reuseNode true
                }                
            }
            steps {

                sh "echo 2"
               
            }
        }

     }
 }
