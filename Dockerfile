FROM tomcat:latest

ADD CSIRGeoTracker-1.0.0.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]
