pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                script {
                    git 'https://github.com/Rekhach9618/Rekha.git'
                }
            }
        }
        stage('Init') {
            steps {
                script {
                    bat 'terraform init'
                }
            }
        }
        stage('Plan') {
            steps {
                script {
                    bat 'terraform plan -out=tfplan'
                }
            }
        }
        stage('Apply') {
            steps {
                script {
                    input message: 'Approve Terraform Apply?'
                    bat 'terraform apply tfplan'
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    bat 'del tfplan'
                }
            }
        }
    }

    post {
        success {
            echo 'Terraform applied successfully!'
        }
        failure {
            echo 'Infrastructure provisioning failed!'
        }
    }
}
