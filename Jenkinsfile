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

        stage('tesst') {
          steps {
            echo 'Clonage termine'
          }
        }

        stage('test3') {
          steps {
            echo 'test4'
          }
        }

        stage('test4') {
          steps {
            echo 'test2'
          }
        }

      }
    }

    stage('Maven Clean Build') {
      steps {
        echo 'test'
        sh 'mvn clean install -Dlicense.skip=true'
      }
    }

  }
  environment {
    DOCKERHUB_CREDENTIALS = 'docker-hub-wissem'
  }
}