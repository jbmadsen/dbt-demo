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
                        sh 'pip freeze list'
                        sh 'echo "run dbt..."'
                        sh 'dbt --version'
                        sh 'echo "--------------- Test ---------------"'
                    }
                }

                // stage('Checkout') {
                //     steps {
                //         git branch: 'master',
                //             url: 'https://github.com/jbmadsen/dbt-demo'
                //     }
                // }
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
        
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                /*
                TODO:
                1) Deploy to prod
                2) Generate docs
                3) Export docs somewhere?
                4) Look into manifest.json and the other compiled items
                    4.1) From there, determine list of jobs schedule to be created
                         Inspiration: 
                            https://www.astronomer.io/blog/airflow-dbt-1 
                            https://www.astronomer.io/blog/airflow-dbt-2
                */
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
