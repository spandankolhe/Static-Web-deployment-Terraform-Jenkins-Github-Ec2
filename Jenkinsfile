pipeline {
  agent any

  environment {
    SSH_CRED_ID = 'ec2-key'                   
    SSH_USER    = 'ubuntu'                    
    EC2_HOST    = '15.206.186.30'       
    WEBROOT     = '/var/www/html'
    REPO_URL    = 'https://github.com/spandankolhe/Static-Web-deployment-Terraform-Jenkins-Github-Ec2.git'   
  }

  stages {

    stage('SSH + Clone Repo') {
      steps {
        sshagent([env.SSH_CRED_ID]) {
          sh """
            echo "Connecting to server ${EC2_HOST} ..."
            ssh -o StrictHostKeyChecking=no ${SSH_USER}@${EC2_HOST} bash -s <<'REMOTE'
              set -e

              cd ${WEBROOT}

              # Remove old files
              sudo rm -rf ./*

              # Clone your repo into /var/www/html
              sudo git clone ${REPO_URL} .

              echo "Cloned ${REPO_URL} into ${WEBROOT}"
            
          """
        }
      }
    }
  }

  post {
    success { echo "Deployment successful → http://${EC2_HOST}/" }
    failure { echo "Deployment failed." }
  }
}
