/* 
Pipeline syntax: 
https://www.jenkins.io/doc/book/pipeline/syntax/ 
*/

pipeline {
    /* Any agent information - specifies where the pipeline will run in the Jenkins environment */
    agent any

    /* Pipeline options */
    options {
        timeout(time: 1, unit: 'HOURS') 
    }

    /* Pipeline stages defined as a sequence of one or more tasks - the bulk of the work */
    stages {
        stage('Setup dbt') {
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

        stage('Build') {
            parallel {
                steps {
                    echo 'Buildin 1...'
                }
                
                steps {
                    echo 'Buildin 2...'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }

    /* Pun upon the completion of stages */
    post { 
        always { 
            cleanWs()
            echo 'Done'
        }
    }

    /* Done */
}
