pipeline {
    
    
    
    agent any
   
    tools {
        maven "mvn"
    }
    environment {
        
        project = 'Gestion' 
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
mkdir -p /var/jenkins_home/workspace/haykel3-ggestion/dockerimages
cd /var/jenkins_home/workspace/haykel3-ggestion/dockerimages
cp /var/jenkins_home/workspace/haykel3-ggestion/target/Gestion.war .
mv Gestion.war ROOT.war
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
                    sh '''cd /var/jenkins_home/workspace/haykel3-ggestion/dockerimages
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

