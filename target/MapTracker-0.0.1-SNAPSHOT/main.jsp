<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Map Tracking</title>
</head>
<style>
#map { height: 600px; }
</style>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css"
   integrity="sha512-hoalWLoI8r4UszCkZ5kL8vayOGVae1oxXe/2A4AO6J9+580uKHDO3JdHb7NzwwzK5xr/Fs0W40kiNHxM9vyTtQ=="
   crossorigin=""/>
   
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
<script src="https://cdn.rawgit.com/dcodeIO/protobuf.js/6.8.8/dist/protobuf.js"></script> 
 <!-- Make sure you put this AFTER Leaflet's CSS -->
 <script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"
   integrity="sha512-BB3hKbKWOc9Ez/TAwyWxNXeoV9c1v6FIeYiBieIWkpLjauysF18NzgR1MBNBXf8/KABdlkX68nAhlwcDFLGPCQ=="
   crossorigin=""></script>
<body>
<center>
<h1>Internal CSIR Bracelet Location Tester</h1>
<div></div>Device <input id="inputTopic" value="ems-00002"></input>  <button onclick="start_topic()">Start</button><br></div>
<p id="lat"></p>
<p id="long">
<p id="time"></p></p></center>
<div id="map"></div>
</body>





<script>


var map = L.map('map').setView([-25.7568505, +28.2783488], 18);
var marker = new L.marker([-90000,-90000]).addTo(map);

var pointA = new L.LatLng(-25.7566505, +28.2783488);
var pointB = new L.LatLng(-25.7566505, +28.2789488);
var pointList = [];
// pointList.push(pointA);
// pointList.push(pointB);





var firstpolyline = new L.Polyline(pointList, {
    color: 'red',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline.addTo(map);
firstpolyline.remove()
firstpolyline.addTo(map);


var polygon1;
var polygon2;

L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}', {
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    maxZoom: 18,
    id: 'mapbox/streets-v11',
    tileSize: 512,
    zoomOffset: -1,
    accessToken: 'pk.eyJ1IjoicmluZWxiIiwiYSI6ImNsM241ZHNxdzBiZGQzY3BiajI2Ymx3NjIifQ.5gDF0yz9GVSrMfTZwB0jQg'
}).addTo(map);

var latv = document.getElementById("lat"); 
var longv = document.getElementById("long"); 
var timeDisplay = document.getElementById("time"); 
latv.innerHTML = "waiting for coordinates"; 
// Create a client instance
// client = new Paho.MQTT.Client("broker.hivemq.com", Number(8000), "clientIdWebAppTest");
client = new Paho.MQTT.Client("146.64.8.98", Number(61614), "clientIdWebAppTest");

 
// set callback handlers
client.onConnectionLost = onConnectionLost;
client.onMessageArrived = onMessageArrived;
console.log("before ran");
// connect the client
//client.connect({onSuccess:onConnect});
client.connect({onSuccess:onConnect,userName : "kapua-sys",	password : "kapua-password"});
// client.loop_forever();
console.log("connect ran");
// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscppwription and send a message.
  console.log("-------------- onConnect --------------------");
//    client.subscribe("kapua-sys/NRF123456789/data");
  message = new Paho.MQTT.Message("Hello");
  message.destinationName = "kapua-sys/NRF123456789/data";
  client.send(message);
}

// called when the client loses its connection
function onConnectionLost(responseObject) {

  if (responseObject.errorCode !== 0) {
    console.log("onConnectionLost:"+responseObject.errorMessage);
  }
}

// called when a message arrives
function onMessageArrived(message) {
// 			  console.log("onMessageArrived:"+message.payloadString);
			
			  var payload1 = message.payloadBytes
			  var length = payload1.length;
			  var buffer1 = new ArrayBuffer(length);
			  var message1  = new Uint8Array(buffer1);
			  console.log("onMessageArrived:");
			  for (var i=0; i<length; i++) {
				  //message1[(length-1)-i] = payload1[i];
				  message1[i] = payload1[i];
			      console.log(i+" :"+message1[(length-1)-i] );
			  }

			  console.log("rinel 1:");

			  protobuf.load("js/kurapayload.proto", function(err1, root) {
				  if (err1){
	 			        throw err1;
	 			       console.log("rinel 0:");
	 			      console.log(err1);
				  }
				  console.log("rinel 1:");
				  var AwesomeMessage = root.lookupType("kuradatatypes.KuraPayload");
				  console.log("rinel 2:");
  			

			    
		
			    // Verify the payload if necessary (i.e. when possibly incomplete or invalid)
			    var errMsg = AwesomeMessage.verify(payload1);
			    if (errMsg){
			    	throw Error(errMsg);
			    	console.log("error with verify");
			    }

			    console.log("rinel 3:");
			    
			    // uncomment to see data
				//console.log(buffer);
				//console.log(message1);
			    // Decode an Uint8Array (browser) or Buffer (node) to a message
			    var message = AwesomeMessage.decode(message1);
			    console.log("rinel 4:");
			    // ... do something with message
			    
			    //uncomment to see data
			    //console.log("message");
				//console.log(message.metric);
				
				//console.log(message.KuraMetric);
				//console.log(message.KuraMetric["1"]);
			    // If the application uses length-delimited buffers, there is also encodeDelimited and decodeDelimited.

			    // Maybe convert the message back to a plain object
			    var object = AwesomeMessage.toObject(message, {
			        longs: String,
			        enums: String,
			        bytes: String,
			        // see ConversionOptions
			    });
			    console.log("Protobuf data ");
	    
			    //uncomment to see data
			    console.log("time: "+object.timestamp);
			    var d = new Date(0); // The 0 there is the key, which sets the date to the epoch
			    d.setUTCSeconds((object.timestamp)/1000);
			    timeDisplay.innerHTML = "Time = "+ d;
// 			    console.log( object.metric[0].name +": "+object.metric[0].doubleValue);
			    console.log( object.metric[1].name +": "+object.metric[1].floatValue);
			    console.log( object.metric[2].name +": "+object.metric[2].floatValue);
// 			    console.log( object.metric[3].name +": "+object.metric[1].doubleValue);
			    firstpolyline.addLatLng([object.metric[2].floatValue, object.metric[1].floatValue]);

			    var newLatLng = new L.LatLng(object.metric[2].floatValue, object.metric[1].floatValue);
			    marker.setLatLng(newLatLng); 
			    latv.innerHTML = "Lat = "+ object.metric[2].floatValue + "";
			    longv.innerHTML = "Long = "+ object.metric[1].floatValue + "";

			    


				/* Working code
			    var newLatLng = new L.LatLng(object.metric[0].doubleValue, object.metric[1].doubleValue);
			    marker.setLatLng(newLatLng); 
			    latv.innerHTML = "lat = "+ object.metric[0].doubleValue + "";
			    longv.innerHTML = "long = "+ object.metric[1].doubleValue + "";

			   /*
			   


			    //data_object = {time:object.timestamp,temp:object.metric[0].doubleValue,ph:object.metric[1].doubleValue}
			    //plot_data.shift();  //to remove first element in the error
			    //plot_data.push(data_object)
			    
			    
				//d3.select("#chart").datum(plot_data).call(chart);
			    //d3.select("#chart").datum(plot_data).call(chart);
			  //  d3.select(window).on('resize', resize);
			    //     {x: 3, y: 70}, {x: 4, y: 40}, {x: 5, y: 80} ];
			  var d = new Date(parseInt(object.timestamp));
			  var time_add =   d.getFullYear()+ d.getMonth+"-"+d.getDate()+ "-"+d.getMinutes()+ "-"+d.getSeconds()+"-"+d.getMilliseconds();
			  
			  var time_add =   d.getHours()+":"+ d.getMinutes()+":"+d.getSeconds()+ "  "+d.getDate()+ "-"+d.getMonth()+"-"+d.getFullYear();
	  
			  /*
			  console.log(" mqtt value :");
			  console.log(" solar value :" +object.metric[0].floatValue+" "+ object.metric[1].floatValue);
			  console.log(" battery value :"+object.metric[2].floatValue+" "+ object.metric[3].floatValue);
			  console.log(" dc1 value :"+object.metric[4].floatValue+" "+ object.metric[5].floatValue);
			  console.log(" dc2 value :"+object.metric[6].floatValue+" "+ object.metric[7].floatValue);
			  console.log(" mppt value :"+object.metric[8].floatValue);*/
			  /*
			  solar voltage :undefined
			  main.jsp:832  solar current :14.529999732971191
			  main.jsp:833  battery voltage :0
			  main.jsp:834  battery current :12.90999984741211
			  main.jsp:835  dc1 voltage :0.20000000298023224
			  main.jsp:836  dc1 current :0
			  main.jsp:837  dc2 value :0
			  main.jsp:838  dc2 value :0
			  main.jsp:839  mppt value :0*/
	  
	  
  			});



  
}


function start_topic(){
	var topic = "kapua-sys/"+document.getElementById("inputTopic").value+"/data"
	console.log("topic : "+topic);
	client.subscribe(topic);
	setTimeout(function(){
		polygon1 = new L.polygon([
			[-25.755736, 28.277955],
			[-25.755937, 28.277925],
			[-25.755958, 28.278146],
			[-25.755953, 28.278397],
			[-25.756017, 28.278856],
			[-25.755696, 28.279089],
			[-25.755665, 28.278311],
			[-25.755736, 28.277955]
	],{
		    color: 'blue',
		    weight: 3,
		    opacity: 0.5,
		    smoothFactor: 1
		}).addTo(map);
	}, 1500); 	

	
	
	setTimeout(function(){
		polygon2 = new L.polygon([
			[-25.756335, 28.277645],
			[-25.756415, 28.277168],
			[-25.757152, 28.277289],
			[-25.757512, 28.277538],
			[-25.757722, 28.278026],
			[-25.757831, 28.278426],
			[-25.757481, 28.278954],
			[-25.757029, 28.278817],
			[-25.756727, 28.278391],
			[-25.756335, 28.277645]
	],{
		    color: 'blue',
		    weight: 3,
		    opacity: 0.5,
		    smoothFactor: 1
		}).addTo(map);
	}, 2000); 
	console.log("subscribtion done");
	
}


</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRmSBAJbhVk0EZ7h9DF4iY4SZzQPcuqrA&callback=myMap"></script>


</html>