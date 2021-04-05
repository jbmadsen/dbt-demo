/* 
Pipeline syntax: 
https://www.jenkins.io/doc/book/pipeline/syntax/ 
*/

/* Pipeline definitions */
def isTargetPlatformWindows = true 

pipeline {
    /* Any agent information - specifies where the pipeline will run in the Jenkins environment */
    agent any

    /* Pipeline options */
    options {
        timeout(time: 1, unit: 'HOURS') 
    }

    /* Pipeline stages defined as a sequence of one or more tasks - the bulk of the work */
    stages {
        stage('Setup') {
            failFast true
            parallel {
                stage('Setup dbt') {
                    steps {
                        sh 'echo "--------------- Test ---------------"'
                        sh 'echo "python version..."'
                        sh 'python --version'
                        sh 'echo "install dbt..."'
                        sh 'pip install dbt'
                        sh 'pip install dbt-sqlserver'
                        sh 'pip install pyodbc'
                        sh 'pip freeze list'
                        sh 'echo "run dbt..."'
                        sh 'dbt --version'
                        sh 'echo "--------------- Test ---------------"'
                    }
                }
            }
        }

        stage('Build') {
            failFast true
            parallel {
                stage('Run') {
                    agent any
                    steps {
                        sh 'echo "running..."'
                        dir("src") {
                            sh "dbt run --profiles-dir ${WORKSPACE}/profiles --target uat"
                        }
                        /*
                        dbt run --profiles-dir /home/git/dbt-demo/profiles --target uat --models state:modified 
                        */
                    }
                }
                
                stage('Snapshot') {
                    agent any
                    steps {
                        sh 'echo "snapshotting..."'
                        dir("src") {
                            sh "dbt snapshot --profiles-dir ${WORKSPACE}/profiles --target uat"
                        }
                        /*
                        dbt snapshot --profiles-dir /home/git/dbt-demo/profiles --target uat --models state:modified 
                        */
                    }
                }
            }
        }
        
        stage('Test') {
            steps {
                sh 'echo "testing..."'
                dir("src") {
                    sh "dbt test --profiles-dir ${WORKSPACE}/profiles --target uat"
                }
                /*
                dbt test --profiles-dir /home/git/dbt-demo/profiles --target uat
                */
            }
        }
        
        stage('Scheduling SQL') {
            when {
                // Idea from: 
                // https://stackoverflow.com/questions/57602609/jenkins-pipeline-stage-skip-based-on-groovy-variable-defined-in-pipeline
                // https://www.jenkins.io/doc/book/pipeline/syntax/#when
                expression { isTargetPlatformWindows == true }
            }
            steps {
                dir("./") {
                    sh "python helpers/apply_schedules.py"
                    sh "python helpers/execute_git_sync.py"
                }
            }
        }

        stage('Scheduling Airflow') {
            when {
                // Idea from: 
                // https://stackoverflow.com/questions/57602609/jenkins-pipeline-stage-skip-based-on-groovy-variable-defined-in-pipeline
                // https://www.jenkins.io/doc/book/pipeline/syntax/#when
                expression { isTargetPlatformWindows == false }
            }
            steps {
                echo 'Coming soon...'
            }
        }
    }

    /* Pun upon the completion of stages */
    post { 
        always { 
            //cleanWs()
            //deleteDir() /* clean up our workspace */
            echo 'Done'
        }
    }

    /* Done */
}
