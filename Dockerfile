FROM tomcat:latest

LABEL maintainer="Squad12"

ADD /var/lib/jenkins/workspace/DockerizeApp/target/AVNCommunication-1.0.war /usr/local/tomcat/webapps/ProdWebapp

EXPOSE 8080

CMD ["catalina.sh", "run"]
