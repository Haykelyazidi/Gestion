pipeline {
  agent any
  stages {
    stage('Git Check Out') {
      steps {
        git(url: 'https://github.com/wissem007/Gestion.git', branch: 'master')
      }
    }

    stage('Maven Clean Build') {
      steps {
        sh 'mvn package -DskipTests=true'
      }
    }

  }
  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-wissem'
  }
}