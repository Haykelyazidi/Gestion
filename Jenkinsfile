pipeline {
  agent any
  stages {
    stage('Git Check Out') {
      steps {
        git(url: 'https://github.com/wissem007/Gestion.git', branch: 'master')
      }
    }

  }
  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-wissem'
  }
}