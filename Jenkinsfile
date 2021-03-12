pipeline {
    agent any

    stages {
        stage('Build') {
            script {
                sh 'echo "--------------- Test ---------------"'
                sh 'pip install dbt'
                sh 'pip freeze list'
                sh 'echo "run dbt....."'
                sh 'dbt --version'
                sh 'echo "--------------- Test ---------------"'
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
