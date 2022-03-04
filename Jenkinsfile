pipeline {
  agent any

  stages {
    stage('build') {
      steps {
          echo '-----run build-----'
          sh app.sh
        }
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