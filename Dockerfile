FROM tomcat:latest

LABEL maintainer="Squad12"

ADD /var/jenkins_home/workspace/DockerizeApp_1_main/target/AVNCommunication-1.0.war /usr/local/tomcat/webapps/ProdWebapp

EXPOSE 8080

CMD ["catalina.sh", "run"]
