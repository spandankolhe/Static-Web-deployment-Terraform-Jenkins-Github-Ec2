pipeline {
  agent any

  environment {
    SSH_CRED_ID = 'ec2-key'                   
    SSH_USER    = 'ubuntu'                    
    EC2_HOST    = '15.206.186.30'       
    WEBROOT     = '/var/www/html'
    REPO_URL    = 'https://github.com/spandankolhe/Static-Web-deployment-Terraform-Jenkins-Github-Ec2.git'
    GIT_BRANCH  = 'main'
  }

  stages {

    stage('SSH + Pull or Clone Repo') {
      steps {
        sshagent([env.SSH_CRED_ID]) {
          sh """
            echo "Connecting to server ${EC2_HOST} ..."

            ssh -o StrictHostKeyChecking=no ${SSH_USER}@${EC2_HOST} bash -s <<'REMOTE'
              set -e

              cd ${WEBROOT}

              # If the folder already contains a git repo → pull latest
              if [ -d ".git" ]; then
                echo "Git repo exists — pulling latest changes..."
                sudo git fetch origin ${GIT_BRANCH}
                sudo git reset --hard origin/${GIT_BRANCH}

              else
                echo "No git repo found — cleaning and cloning fresh..."
                sudo rm -rf ./*
                sudo git clone --branch ${GIT_BRANCH} ${REPO_URL} .
              fi

              echo "Deployment completed in ${WEBROOT}"
REMOTE
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
