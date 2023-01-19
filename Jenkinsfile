pipeline {
  agent any
  stages {
    stage('Git Check Out') {
      parallel {
        stage('Git Check Out') {
          steps {
            git(url: 'https://github.com/wissem007/Gestion.git', branch: 'master')
          }
        }

        stage('') {
          steps {
            echo 'Clonage termine'
          }
        }

      }
    }

    stage('Maven Clean Build') {
      steps {
        echo 'test'
      }
    }

  }
  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-wissem'
  }
}