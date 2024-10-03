pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker-compose build'
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'docker-compose up -d'
                }
            }
        }
        stage('Run Unit Tests') {
            steps {
                script {
                    sh 'docker exec HW_CI_test pytest -v'
                }
            }
        }
        stage('Run Robot Framework Tests') {
            steps {
                script {
                    sh 'mkdir -p test_results'

                    sh 'docker exec HW_CI_test robot --outputdir /srv/HW_CI_test/tests/robot tests/robot/api_test.robot'
                    
                    sh 'docker cp HW_CI_test:/srv/HW_CI_test/tests/robot/output.xml test_results/output.xml'
                    sh 'docker cp HW_CI_test:/srv/HW_CI_test/tests/robot/log.html test_results/log.html'
                    sh 'docker cp HW_CI_test:/srv/HW_CI_test/tests/robot/report.html test_results/report.html'
                }
            }
            post {
                always {
                    step([
                            $class              : 'RobotPublisher',
                            outputPath          : 'test_results',
                            outputFileName      : "output.xml",
                            reportFileName      : 'report.html',
                            logFileName         : 'log.html',
                            disableArchiveOutput: false,
                            passThreshold       : 95.0,
                            unstableThreshold   : 95.0,
                            otherFiles          : "**/*.png",
                    ])
                }
            }
        }
        stage('Check Status') {
            steps {
                script {
                    sh 'docker-compose ps'
                }
            }
        }
        stage('Clean Up') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker rmi my-python-dev-env'
                }
            }
        }
    }

    post {
        always {
            script {
                sh 'docker-compose down || true'
                sh 'docker image prune -f'
            }
        }
    }
}
