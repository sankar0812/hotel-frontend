pipeline {
    agent any
    // agent {
    //     label 'k8s'
    // }
    environment {
       DOCKERHUB_CREDENTIALS = credentials('docker-hub-ideaux')
    }
    // environment {
    //     DOCKERHUB_CREDENTIALS_USR = credentials('DockerHubUsername')
    //     DOCKERHUB_CREDENTIALS_PSW = credentials('DockerHubPassword')
    // }

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
                     bat "docker login -u ${DOCKERHUB_CREDENTIALS_USR} -p ${DOCKERHUB_CREDENTIALS_PSW}"
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
        stage('Deploy to Kubernetes') {
            steps {
                script {
                   def kubeconfigPath = 'C:\\Users\\IdeauxTechPvt\\.kube\\config'
                   kubeconfig(credentialsId: 'k8s', serverUrl: '') {
                       sh 'kubectl config view' // Check kubectl configuration
                       sh "kubectl apply -f C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\hotel-dev\\deployment.yaml" // Apply Kubernetes deployment
                       sh 'kubectl get pods' // Check the status of pods
                
                    }
                }
                //   kubeconfig {
                //         credentials('k8s')
                //         cloudName('k8s')
                //   }
                //   bat "kubectl apply -f deployment.yml --validate=false"
                // } 
                // script {
                //     // Use kubectl to apply your deployment.yaml file
                //     withCredentials([kubeconfig(credentialsId: 'k8s')]) {
                //         sh "kubectl --kubeconfig=\$kubeconfig apply -f deployment.yml --validate=false"
                //     }
                //     //kubeconfig = credentials('k8s')
                //     //bat "kubectl --kubeconfig=${kubeconfig} apply -f deployment.yml --validate=false"
                //     //bat "kubectl apply -f deployment.yml"
                // }
            }
        }

        // stage('Pull Docker Image from Docker Hub') {
        //     steps {
        //         script {
        //             bat 'docker pull ideauxhub/hotel:latest'
        //         }
        //     }
        // }

        // stage('Run Docker Container') {
        //     steps {
        //         script {
        //             bat 'docker run -d --name my-container -p 3000:3000 ideauxhub/hotel:latest'
        //         }
        //     }
        // }
    }
}
