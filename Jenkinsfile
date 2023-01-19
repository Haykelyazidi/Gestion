pipeline {
  agent any
  stages {
    stage('Git Check Out') {
      steps {
        git(url: 'https://github.com/wissem007/Gestion.git', branch: 'master')
      }
    }

    stage('Build docker image') {
      steps {
        sh 'docker build -t wissem007/nodeapp:$BUILD_NUMBER .'
      }
    }

  }
  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-wissem'
  }
}