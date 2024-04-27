pipeline {
    agent any

    tools {
        // Make sure 'Git' refers to the tool name configured in Global Tool Configuration
        git 'Git'
    }

    // stages {
    //     stage('Clone Repository') {
    //         steps {
    //             sh 'git clone https://sankarasubramanian1999:k72yfjjbq2ynt34hjc37c5d7hxrxakwgowv5lvdtsvtbbr7xeb6q@dev.azure.com/sankarasubramanian1999/Azure-devops_demo/_git/hotel-frontend'
    //         }
    //     }

        stage('Set up environment variables') {
            steps {
                script {
                    sh 'echo "BUILD_NUMBER=${BUILD_NUMBER}" > .env'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t sankar0812/hotel:${BUILD_NUMBER} .'
                }
            }
        }

        stage('Log in to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-sankar', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    sh 'docker push sankar0812/hotel:${BUILD_NUMBER}'
                }
            }
        }

        stage('Delete Local Docker Image') {
            steps {
                script {
                    sh 'docker rmi sankar0812/hotel:${BUILD_NUMBER}'
                }
            }
        }

        stage('Pull Docker Image from Docker Hub') {
            steps {
                script {
                    sh 'docker pull sankar0812/hotel:${BUILD_NUMBER}'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    sh 'docker run -d --name my-container sankar0812/hotel:${BUILD_NUMBER}'
                }
            }
        }
    }
}
