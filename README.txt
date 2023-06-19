NOTE: The WAR file and the Docker file must be on the same folder, where you run the following docker commands:


TO BUILD, execute this command:
docker build -t tomcat-csir-dcs-geotracker .


TO RUN, execute this command:
docker run -d -p 8089:8080 tomcat-csir-dcs-geotracker


TO ACCESS THE WEB APP, go to URL:
http://146.64.8.98:8089/geotracker/main.jsp

 


url for live server
http://146.64.8.98:8089/geotracker/main.jsp

url for local testing
http://localhost:8080/geotracker/main.jsp