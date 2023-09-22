pipeline {
    
    
    
    agent any
   
    tools {
        maven "mvn"
    }
    environment {
        
        project = 'gestion' 
        imageVersion = 'v' 
        imageTag = "haydevops/${project}:${imageVersion}.${env.BUILD_NUMBER}" 
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "141.95.254.226:8081"
        NEXUS_REPOSITORY = "maven-nexus-repo"
        NEXUS_CREDENTIAL_ID = "nexus-user-credentials"
    }
    stages {
        stage("Clone code from VCS") {
            steps {
                script {
                    git 'https://github.com/Haykelyazidi/Gestion.git';
                }
            }
        }
        stage("Maven Build") {
            steps {
                script {
                   //sh "mvn package -DskipTests=true"
                   //sh "mvn -Dmaven.test.failure.igonre=true clean package"
                   sh "mvn clean package"
                }
            }
        }  
       // stage('SonarQube analysis') {
         //   steps {
           //  script {
         //    withSonarQubeEnv('SonarQube') {
         //sh 'mvn clean package sonar:sonar'
      //}
   // }
 // }
//}   

        
        
        stage("Docker Image File"){
            steps {
                script {
      sh '''rm -rf /var/jenkins_home/workspace/haykel3-Gestion/dockerimages
mkdir -p /var/jenkins_home/workspace/haykel3-Gestion/dockerimages
cd /var/jenkins_home/workspace/haykel3-Gestion/dockerimages
cp /var/jenkins_home/workspace/haykel3-Gestion/target/Gestion.war .

touch dockerfile
cat <<EOT>> dockerfile
FROM tomcat:8-jre8                          
# MAINTAINER                                
MAINTAINER "haykel"                         
# COPY WAR FILE ON TO Contaire              
COPY ./Gestion.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
EXPOSE 8080
EOT'''
              }
          }
        }
        stage("Build Docker Image"){
            steps {
                script {
                    sh '''cd /var/jenkins_home/workspace/haykel3-Gestion/dockerimages
docker build -t ${imageTag} .''' 
      
              }
          }
        }
          stage("Docker Push"){
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker_hub', variable: 'DOCKER_CREDENTIALS')]) {
                     sh "echo $DOCKER_CREDENTIALS | docker login -u haydevops --password-stdin"
                     sh "docker push ${imageTag}"
        }
          
      
              }
          }
        }
        
        stage('Cleaning up') {
             steps {
                script {
    
        sh "docker rmi ${imageTag}"
                       }
                 
                   }
             
        }
         stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "Gestion"
            GIT_USER_NAME = "Haykelyazidi"
        }
        steps {
           
                sh '''            
                    git config --global user.email "haykel.yazidi@gmail.com"
                    git config --global user.name "Haykelyazidi"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/gestion:v.[0-9]*/gestion:v.\${BUILD_NUMBER}/" dev/deployment.yaml
                    git add -A dev/deployment.yaml
                    git commit -m "Update deployment image to version ${imageTag}"
                    '''
                    //git push origin main
                    withCredentials([string(credentialsId: 'github_credentials', variable: 'token_hub')]) {
                    // sh 'git push https://github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main'                    
                     sh 'git push https://${token_hub}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main'                   
                   
                   }

          
        }
    }
  
         stage('Remove Container') {
            steps {
                script {
                    def containerName = 'haykel_Gestion' // Remplacez par le nom de votre conteneur
                    
                    def containerId = sh(script: "docker ps -aq -f name=${containerName}", returnStdout: true).trim()
                    if (containerId) {
                        sh "docker rm -f ${containerName}"
                        echo "Container '${containerName}' has been removed."
                    } else {
                        echo "No container found with the name '${containerName}'."
                       // sh 'docker run -d --name haykel_java -p 8050:8080 ${IMAGE}'
                    }
                }
            }
        }
         stage('Docker RUN') {
             steps {
                script {
        sh "docker rm -f Gestion "
        sh "docker run -itd --name haykel_Gestion -p 8888:8080 ${imageTag}"
                       }
                 
                   }
             
        }
        
      
    }
        
        
        
}

