pipeline {
  agent any
  stages {
    stage('git') {
      steps {
        echo 'Cloning Git hub jenkins file'
        git(credentialsId: 'Github', url: 'https://github.com/squad12-devops/DevOps-Demo-WebApp.git')
      }
    }
    //stage(' Static Code Analysis - SonarQube') {
    //       steps{
    //           withSonarQubeEnv(credentialsId: 'sonar', installationName: 'sonarqube') {
    //             sh "${tool("sonarqube")}/bin/sonar-scanner \
     //           -Dsonar.projectKey=. \
     //           -Dsonar.sources=. \
     //           -Dsonar.tests=. \
     //           -Dsonar.inclusions=**/test/java/servlet/createpage_junit.java \
     //           -Dsonar.test.exclusions=**/test/java/servlet/createpage_junit.java \
    //            -Dsonar.login=admin \
    //            -Dsonar.password=sonar "
    //             sh 'mvn validate -f pom.xml'
    //            }
    //       }
   // }

    stage('Compile') {
      steps {
        echo 'compiling project'
        sh 'mvn compile'
      }
    }
    
    stage('Deploy to QA') {
           steps {
               sh 'mvn package -f pom.xml' 
               deploy adapters: [tomcat8(credentialsId: 'tomcat', path: '', url: 'http://100.25.194.166:8080')], contextPath: '/QAWebapp', onFailure: false, war: '**/*.war'
               echo 'Notification send - Deploy to QA'
               slackSend channel: '#squad12', message: ' Deploy to QA successful'
               
           }
           
            post {
                    always {
                         jiraSendBuildInfo site: '12squaddevops.atlassian.net',  branch: 'master'
                    }
            }
    }
    stage('Post QA Stages') {
	    parallel{
        stage('Store the Artifacts in JFrog') {
            steps {
                echo 'Test step slack'
                slackSend channel: '#squad12', message: 'Build successful'
                rtUpload (
                    serverId: 'deepikarspb',
                    spec: """{
                            "files": [
                                    {
                                        "pattern": "/var/jenkins_home/workspace/TestJenkinsPipeline11/target/AVNCommunication-1.0.war",
                                        "target": "libs-snapshot-local"
                                    }
                                ]
                            }"""
                        )
                }
        }
        stage('Slack') {
            steps {
                slackSend channel: '#squad12', message: 'Build successful'
	    }
	}
	
        stage('Perform UI Test Sanity Test  & Publish HTML Report') {
            steps{
                sh 'mvn test -f functionaltest/pom.xml'
                publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '\\functionaltest\\target\\surefire-reports', reportFiles: 'index.html', reportName: 'Sanity Test HTML Report', reportTitles: 'HTML Report'])
                }
        }
	}
    }
    

    
    stage('Deploy to PROD') {
           steps {
               sh 'mvn package -f pom.xml' 
               deploy adapters: [tomcat8(credentialsId: 'tomcat', path: '', url: 'http://54.236.26.90:8080')], contextPath: '/ProdWebapp', onFailure: false, war: '**/*.war'
               echo 'Notification send - Deploy to PROD'
               slackSend channel: '#squad12', message: ' Deploy to PROD successful'
             }
    }
    
    stage('Perform Sanity test in PROD') {
        steps{
            sh 'mvn test -f Acceptancetest/pom.xml'
            publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '\\Acceptancetest\\target\\surefire-reports', reportFiles: 'index.html', reportName: 'Sanity Test HTML Report', reportTitles: ''])
            echo 'Notification send - Sanity test in PROD completed'
            slackSend channel: '#squad12', message: ' Sanity test in PROD completed successfully'
            }
    }
    
  }
  environment {
    PATH = "/var/jenkins_home/apache-maven-3.5.4/bin:$PATH"
  }
}
