def remote = [:]
remote.name = 'brayanmarin'
remote.host = '172.28.92.49'
remote.allowAnyHosts = true

pipeline {
    agent any // 'agent' should be outside the 'environment' block and directly under 'pipeline'
    environment {
        dockerImageName = 'merxxaz/python-app:v1.0.0'
        dockerImage = ''
        SSH_CREDS = credentials('23f6de3f-0ddf-4ca8-9c0d-18960773cd0e')
        TERRAFORM_DIR = '/home/brayanmarin/DevOps/miniProjects/5thWeek/testFilesTerraform'
    }
    stages {
        stage('SSH Connection') {
            steps {
                script {
                    // Assuming SSH_CREDS_USR and SSH_CREDS_PSW are environment variables, they should be accessed as follows:
                    remote.user = env.SSH_CREDS_USR
                    remote.password = env.SSH_CREDS_PSW
                }
            }
        }
        stage('Checkout Source') {
            steps {
                sh 'ls'
            }
        }
        stage('Sending terraform files') {
            steps {
                script {
                    def terraformFiles = sh(script: 'find . -name \"*.tf\"', returnStdout: true).trim()
                    echo "Terraform files: ${terraformFiles}"

                    terraformFiles.tokenize('\n').each {
                        file ->
                            def filePath = file.replaceFirst('^\\./', '')
                            sshPut(remote: remote, from: filePath, into: TERRAFORM_DIR) // 'sshPut' should be a valid step, provided by an SSH Pipeline Steps plugin
                    }
                }
            }
        }
        stage('Terraform Init and Apply') { // Combined Terraform Init and Apply stages for simplicity
            steps {
                script {
                    sshCommand(remote: remote, command: "cd ${TERRAFORM_DIR} && terraform init && terraform apply -auto-approve") // '-auto-approve' is the correct flag, not '-auto'
                }
            }
        }
    }
}
