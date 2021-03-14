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
            failFast true
            parallel {
                stage('Run') {
                    agent any
                    steps {
                        echo "Running..."
                        /*
                        TODO:
                        dbt run --profiles-dir /home/git/dbt-demo/profiles --target uat --models state:modified 
                        */
                    }
                }
                
                stage('Snapshot') {
                    agent any
                    steps {
                        echo "Snapshotting..."
                        /*
                        TODO:
                        dbt snapshot --profiles-dir /home/git/dbt-demo/profiles --target uat --models state:modified 
                        */
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Testing...'
                /*
                TODO:
                dbt test --profiles-dir /home/git/dbt-demo/profiles --target uat
                */
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
