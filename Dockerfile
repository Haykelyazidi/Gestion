FROM tomcat:8-jre8                          
# MAINTAINER                                
MAINTAINER "Wissem"                         
# COPY WAR FILE ON TO Contaire              
COPY ./Gestion.war /usr/local/tomcat/webapps
