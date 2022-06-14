NOTE: The WAR file and the Docker file must be on the same folder, where you run the following docker commands:


TO BUILD, execute this command:
docker build -t tomcat-csir-geotracker .


TO RUN, execute this command:
docker run -d -p 8088:8080 tomcat-csir-geotracker


TO ACCESS THE WEB APP, go to URL:
http://146.64.8.98:8088/CSIRGeoTracker-1.0.0/main.jsp

