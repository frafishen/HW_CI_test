pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t my-python-dev-env .'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Start the services in detached mode
                    sh 'docker-compose up -d'
                }
            }
        }
        stage('Test') {
            steps {
                script {
                    sh 'docker exec HW_CI_test pytest -v'
                    sh 'docker exec HW_CI_test pytest'
                }
            }
        }
        stage('Check Status') {
            steps {
                script {
                    // Check the status of the containers
                    sh 'docker-compose ps'
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    // Stop the services
                    sh 'docker-compose down'
                    
                    // Remove the Docker image
                    sh 'docker rmi my-python-dev-env'
                }
            }
        }
    }

    post {
        always {
            script {
                // Ensure that the containers are stopped and removed if there was a failure
                sh 'docker-compose down || true'
                // Optionally, clean up any dangling images
                sh 'docker image prune -f'
            }
        }
    }
}
