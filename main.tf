pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Rekhach9618/Rekha.git'
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') { // Adjust this if your .tf files are in a different directory
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') { // Same adjustment here
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') { // Same adjustment here
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
        success {
            echo 'Infrastructure provisioned successfully!'
        }
        failure {
            echo 'Infrastructure provisioning failed.'
        }
    }
}
