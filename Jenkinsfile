pipeline {
    
    agent any
   
    tools {
        maven "Maven"
    }
    environment {
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
                    git 'https://github.com/wissem007/Gestion.git';
                }
            }
        }
        stage("Maven Build") {
            steps {
                script {
                   //sh "mvn package -DskipTests=true"
                   sh "mvn -Dmaven.test.failure.igonre=true clean package"
                   //sh "mvn clean package"
                }
            }
        }  
        stage('SonarQube analysis') {
            steps {
             script {
             withSonarQubeEnv('SonarQube') {
         sh 'mvn clean package sonar:sonar'
      }
    }
  }
}   
              stage("Build Docker Image"){
        steps {
            script {
        
      sh '''rm -rf /var/jenkins_home/workspace/cicijenkinsfile/dockerimages
mkdir /var/lib/jenkins/workspace/cicijenkinsfile/dockerimages
cd /var/lib/jenkins/workspace/cicijenkinsfile/dockerimages
cp /var/lib/jenkins/workspace/cicijenkinsfile/target/Gestion.war .
touch dockerfile
cat <<EOT>> dockerfile
FROM tomcat:8-jre8                          
# MAINTAINER                                
MAINTAINER "Wissem"                         
# COPY WAR FILE ON TO Contaire              
COPY ./Gestion.war /usr/local/tomcat/webapps
CMD ["catalina.sh", "run"]
EXPOSE 8080
EOT
docker build -t tom:1.0 .
docker rm -f Gestion
docker run -itd --name Gestion -p 8888:8080 tom:1.0'''
    }
        }
    }
        
        
        
        
          
        stage("Publish to Nexus Repository Manager") {
            steps {
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: NEXUS_VERSION,
                            protocol: NEXUS_PROTOCOL,
                            nexusUrl: NEXUS_URL,
                            groupId: pom.groupId,
                            version: pom.version,
                            repository: NEXUS_REPOSITORY,
                            credentialsId: NEXUS_CREDENTIAL_ID,
                            artifacts: [
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging],
                                [artifactId: pom.artifactId,
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
        
       
    }
}
