
pipeline {
  agent any

  stages {
    stage('build') {
        sh app.sh
      }
      post {
        success {
          echo 'success'
        }
        failure {
          echo 'failure'
        }
      }
    }
  }
}