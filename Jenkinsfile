pipeline {
    agent any

    // tools {
    //     // Make sure 'Git' refers to the tool name configured in Global Tool Configuration
    //     git 'Git'
    // }

    stages { 
        // stage('SCM Checkout') {
        //     steps {
        //        git 'https://github.com/sankar0812/hotel-frontend.git'
        //     }
        // }

        stage('Set up environment variables') {
            steps {
                script {
                    bat 'echo "BUILD_NUMBER=${BUILD_NUMBER}" > .env'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t ideauxhub/hotel:${BUILD_NUMBER} .'
                }
            }
        }

        stage('Log in to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-ideaux', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        bat 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                    }
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    bat 'docker push ideauxhub/hotel:${BUILD_NUMBER}'
                }
            }
        }

        stage('Delete Local Docker Image') {
            steps {
                script {
                    bat 'docker rmi ideauxhub/hotel:${BUILD_NUMBER}'
                }
            }
        }
        // stage('Deploy to Kubernetes') {
        //     steps {
        //         script {
        //             // Use kubectl to apply your deployment.yaml file
        //             bat 'kubectl apply -f deployment.yaml'
        //         }
        //     }
        // }

        stage('Pull Docker Image from Docker Hub') {
            steps {
                script {
                    bat 'docker pull ideauxhub/hotel:${BUILD_NUMBER}'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    bat 'docker run -d --name my-container -p 3000:3000 ideauxhub/hotel:${BUILD_NUMBER}'
                }
            }
        }
    }
}
