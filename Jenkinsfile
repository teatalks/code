pipeline {
	agent any
  	environment{
    		PATH="/var/jenkins_home/apache-maven-3.5.4/bin:$PATH"
  	}
	stages{
		stage("git"){
      			steps{
				echo("Cloning Git hub jenkins file")
				git credentialsId: 'Github', url: 'https://github.com/squad12-devops/DevOps-Demo-WebApp.git'
        		}
		}
		stage("Static Code Analysis"){
      			steps{
				echo("validating project")
				sh "mvn validate"
        		}
		}
    		stage("Compile"){
      			steps{
				echo("compiling project")
				sh "mvn compile"
        		}
		}
    		stage("Build"){
      			steps{
				echo("build package")
				sh "mvn package"
        		}
		}
		stage("Last Step"){
      			steps{
				echo("Test step slack")
				
        		}
		}
	}

}
