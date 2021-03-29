pipelineJob('dbt-pipeline') {
    description('CI/CD pipeline for dbt project in same repository')
    properties {
        customIcon('https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png')
        sidebarLinks {
            link('https://github.com/jbmadsen/dbt-demo', 'Github', 'https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png')
        }
    }
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://github.com/jbmadsen/dbt-demo.git')
                    }
                    // Workaround this bug: https://stackoverflow.com/questions/46684972/jenkins-throws-java-lang-illegalargumentexception-invalid-refspec-refs-heads
                    branch('*/*') 
                }
            }
            //lightweight()
            triggers {
                scm('* * * * *')
            }
            scriptPath('Jenkinsfile')
        }
    }
}
