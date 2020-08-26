# Pull base image 
From tomcat:latest 

# Maintainer 
MAINTAINER "mrstlaurent1995@gmail.com" 
COPY /opt/jenkins_files/webapp.war /usr/local/tomcat/webapps

