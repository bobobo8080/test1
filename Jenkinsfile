pipeline {
    agent {label "slave1"}
    environment {
        DOCKER_IMAGE = "my-app"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout([
                    $class: 'GitSCM',
                    branches: [[name: 'main']],
                    userRemoteConfigs: [[
                        url: 'git@github.com:bobobo8080/project2.git',
                        credentialsId: ''
                    ]]
                ])
            }
        }
        stage('Clone repository') {
            steps {
                git branch: 'main', url: 'https://github.com/bobobo8080/project2.git'
            }
        }
        stage('Build Docker image') {
            steps {
                sh "docker build -t flaskapp1 ."
            }
        }
        stage('Run unit tests') {
            steps {
                sh "docker run flaskapp1 npm test"
            }
        }
    }
}
