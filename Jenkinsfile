pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'echo "--------------- Test ---------------"'
                sh 'echo "python version....."'
                sh 'python --version'
                sh 'echo "install dbt....."'
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
