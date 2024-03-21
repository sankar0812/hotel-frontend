pipeline {
    agent any
    // environment {
    //    DOCKERHUB_CREDENTIALS = credentials('docker-hub-ideaux')
    // }
    environment {
        DOCKERHUB_CREDENTIALS_USR = credentials('DockerHubUsername')
        DOCKERHUB_CREDENTIALS_PSW = credentials('DockerHubPassword')
    }

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

        // stage('Set up environment variables') {
        //     steps {
        //         script {
        //             bat 'echo "BUILD_NUMBER=${BUILD_NUMBER}" > .env'
        //         }
        //     }
        // }

        stage('Build Docker Image') {
            steps {
                script {
                    bat 'docker build -t ideauxhub/hotel:latest .'
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                script {
                    echo "Docker Hub Username: ${DOCKERHUB_CREDENTIALS_USR}"
                    echo "Docker Hub Password: ${DOCKERHUB_CREDENTIALS_PSW}"
                    
                    // Define Docker credentials
                    def dockerCreds = [
                        registryUrl: "https://index.docker.io/v1/",
                        credentialsId: DOCKERHUB_CREDENTIALS_USR
                    ]
                    
                    // Login to Docker Hub
                    docker.withRegistry(dockerCreds) {
                        echo "${DOCKERHUB_CREDENTIALS_PSW}" | bat(script: "docker login -u ${DOCKERHUB_CREDENTIALS_USR} --password-stdin", returnStatus: true)
                    }
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    bat 'docker push ideauxhub/hotel:latest'
                }
            }
        }

        stage('Delete Local Docker Image') {
            steps {
                script {
                    bat 'docker rmi ideauxhub/hotel:latest'
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
                    bat 'docker pull ideauxhub/hotel:latest'
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    bat 'docker run -d --name my-container -p 3000:3000 ideauxhub/hotel:latest'
                }
            }
        }
    }
}
