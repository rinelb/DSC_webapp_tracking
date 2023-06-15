
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- http://localhost:8080/geotracker/main.jsp -->
<meta charset="UTF-8">
<title>Geo Tracker</title> 
    
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

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
   
   <!-- Add jQuery and Bootstrap JavaScript libraries -->
  <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
   
<body>
<h1  style="display: flex;text-align: top;align-items: center;justify-content: center;" ><img src ="img/logo.png" width="135" height="60"/>&nbsp; &nbsp; 
<img src ="img/cropped-newnew.png" width="150" height="60" /><span style="font-size:50px;">&nbsp; Geo Tracker</span></h1><br>
<table class="table table-bordered">
  <tbody>
    <tr>
		<td>
		<center>
				<div style="display:none">
				      <input type="radio" id="option1" name="options" value="option1" >
				      <label for="option1">track one bracelet</label>
				    
				      <input type="radio" id="option2" name="options" value="option2" checked>
				      <label for="option2">track munitply bracelets</label>
				    </div>
				  <div style=padding-bottom:15px;"  my-2>  
				    <button type="button" class="btn btn-primary" id="hideGui" onclick="Hide()">Hide Devices</button> &nbsp;  &nbsp; 
				   
				<button  id="start_button" type="button" class="btn btn-danger"  onclick="start_topic()">Connecting</button>
				</div>
				 <div id="bracelet_list">   
				 
				<div style="display:none"> Device <input id="inputTopic" value="ems-00002"></input>  <br></div> 
				 <div class="form-group"  my-2 >
						<select id = "bracelet1" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox1" > &nbsp; <input type="text" id="name1" > <br>
						<select id = "bracelet2" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox2"  >&nbsp; <input type="text" id="name2" ><br>
						<select id = "bracelet3" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox3">&nbsp; <input type="text" id="name3" ><br>
						<select id = "bracelet4" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox4" >&nbsp; <input type="text" id="name4" ><br>
						<select id = "bracelet5" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox5" >&nbsp; <input type="text" id="name5" ><br>
						<select id = "bracelet6" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox6" >&nbsp; <input type="text" id="name6" ><br>
						<select id = "bracelet7" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox7" >&nbsp; <input type="text" id="name7" ><br>
						<select id = "bracelet8" onchange = "favTutorial()" >  
						</select> &nbsp; <input type="checkbox" id="checkbox8" >&nbsp; <input type="text" id="name8" ><br>
						<select id = "bracelet9" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox9" >&nbsp; <input type="text" id="name9" ><br>
						<select id = "bracelet10" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox10" >&nbsp; <input type="text" id="name10" ><br>
					  </div>
					  
					  	
				</div>
				 
				
				</center>
		</td>
		
		<td>
			<center>
			<div style="padding-top:5px;"  my-2>
						<p id="bracelet_lat_long"></p>
				<p id="lat"></p>
				<p id="long">
				<p id="time"></p><p id="rssi"></p></p>
				
				</div>
				
			</center>
		
		</td>
		
  </tr>
  </tbody>
</table>
<center>
<div style="padding-top:15px;"  my-2>
				<input type="checkbox" id="checkBoxFoll" checked="false">
				<label for="checkBoxFoll">Center the marker on the map to : </label> <select id = "trackdevice" onchange = "favTutorial()" >  </select></div> 
<br>
<div id="keyofmarker"></div></center>
<div id="map"></div>

</body>

<script>  
function favTutorial() {  
var mylist = document.getElementById("myList");  
document.getElementById("favourite").value = mylist.options[mylist.selectedIndex].text;  
}  


for (let i = 1; i < 11; i++) {
	var id_call_back = "checkbox" + i;
    const checkbox = document.getElementById(id_call_back);
   
    checkbox.addEventListener("change", function() {
      console.log("Checkbox " + i + " is now " + checkbox.checked);
    });
  }
</script> 



<script>  
function Hide() {  
	if (document.getElementById("hideGui").innerHTML === "Show Devices"){
		document.getElementById("hideGui").innerHTML = "Hide Devices"
		document.getElementById("bracelet_list").style.display = "block";
	}else{
		document.getElementById("hideGui").innerHTML = "Show Devices";
		document.getElementById("bracelet_list").style.display = "none";
	}
  }
</script> 


<script>
function load_data(){
bracelet_list1 = document.getElementById('bracelet1');
bracelet_list2 = document.getElementById('bracelet2');
bracelet_list3 = document.getElementById('bracelet3');
bracelet_list4 = document.getElementById('bracelet4');
bracelet_list5 = document.getElementById('bracelet5');
bracelet_list6 = document.getElementById('bracelet6');
bracelet_list7 = document.getElementById('bracelet7');
bracelet_list8 = document.getElementById('bracelet8');
bracelet_list9 = document.getElementById('bracelet9');
bracelet_list10 = document.getElementById('bracelet10');

count1 = 0;
count2 = 1;
count3 = 2;
count4 = 3;
count5 = 4;
count6 = 5;
count7 = 6;
count8 = 7;
count9 = 8;
count10 = 9;
var zoomsize = 18



					
		console.log("bracelets.length ",bracelets.length);
		for (var i=0 ; i< bracelets.length; i++){ 
			myOption = document.createElement("option");
			myOption.text =bracelets[i];
			myOption.value = bracelets[i];
			bracelet_list1.appendChild(myOption);
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count2];
			myOption.value = bracelets[count2];
			bracelet_list2.appendChild(myOption);
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count3];
			myOption.value = bracelets[count3];
			bracelet_list3.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count4];
			myOption.value = bracelets[count4];
			bracelet_list4.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count5];
			myOption.value = bracelets[count5];
			bracelet_list5.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count6];
			myOption.value = bracelets[count6];
			bracelet_list6.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count7];
			myOption.value = bracelets[count7];
			bracelet_list7.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count8];
			myOption.value = bracelets[count8];
			bracelet_list8.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count9];
			myOption.value = bracelets[count9];
			bracelet_list9.appendChild(myOption);
			
			
			myOption = document.createElement("option");
			myOption.text =bracelets[count10];
			myOption.value = bracelets[count10];
			bracelet_list10.appendChild(myOption);
			
			
			count1 =count1 +1;
			count2 =count2 +1;
			count3 =count3 +1;
			count4 =count4 +1;
			count5 =count5 +1;
			count6 =count6 +1;
			count7 =count7 +1;
			count8 =count8 +1;
			count9 =count9 +1;
			count10 =count10 +1;
			
			if (count1 > bracelets.length){count1 = 0;}
			if (count2 > bracelets.length){count2 = 0;}
			if (count3 > bracelets.length){count3 = 0;}
			if (count4 > bracelets.length){count4 = 0;}
			if (count5 > bracelets.length){count5 = 0;}
			if (count6 > bracelets.length){count6 = 0;}
			if (count7 > bracelets.length){count7 = 0;}
			if (count8 > bracelets.length){count8 = 0;}
			if (count9 > bracelets.length){count9 = 0;}
			if (count10 > bracelets.length){count10 = 0;}
			
			
			
			
			
			
		}
}

			

</script> 


<script>
var icon_list_url = ["https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-red.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-blue.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-green.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-orange.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-violet.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-black.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-gold.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-grey.png",
	"https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-orange.png",
	"https://cdn.pixabay.com/photo/2016/12/18/11/04/pointer-1915456_960_720.png"];
	
var all_devices = [];
var all_topice = [];
var topic_subscribe_index = [];
var topic_subscribe_bracelet = [];
var topic_subscribe_bracelet_name = [];

var follow_device = [];

var map = L.map('map').setView([-25.7568505, +28.2783488], 18);
var marker = new L.marker([-90000,-90000]).addTo(map);


var icon1 = L.icon({
	  iconUrl: 'https://cdn.jsdelivr.net/gh/pointhi/leaflet-color-markers@master/img/marker-icon-red.png',
	  iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
	});
var marker1 = new L.marker([-90000,-90000], {
	  icon:icon1}).bindTooltip(" ", 
			    {
	        permanent: true, 
	        direction: 'right'
	    }).addTo(map);
var icon2 = L.icon({
	  iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png',
	  iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
	});
var marker2 = new L.marker([-90000,-90000], {
	  icon:icon2}).bindTooltip(" ", 
			    {
	        permanent: true, 
	        direction: 'right'
	    }).addTo(map);
	  
	  
var icon3 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker3 = new L.marker([-90000,-90000], {
	icon:icon3}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);

	
	
	
var icon4 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-violet.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker4 = new L.marker([-90000,-90000], {
	icon:icon4}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
	
	
var icon5 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-black.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker5 = new L.marker([-90000,-90000], {
	icon:icon5}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
	
var icon6 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-gold.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker6 = new L.marker([-90000,-90000], {
	icon:icon6}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
var icon7 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-grey.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker7 = new L.marker([-90000,-90000], {
	icon:icon7}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
var icon8 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-yellow.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker8 = new L.marker([-90000,-90000], {
	icon:icon8}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
var icon9 = L.icon({
    iconUrl: 'https://cdn.rawgit.com/pointhi/leaflet-color-markers/master/img/marker-icon-orange.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker9 = new L.marker([-90000,-90000], {
	icon:icon9}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
	

var icon10 = L.icon({
    iconUrl: 'https://cdn.pixabay.com/photo/2016/12/18/11/04/pointer-1915456_960_720.png',
    iconSize:  [19, 45],
	  iconAnchor: [8, 45],
	  popupAnchor: [-3, 0]
});	  
var marker10 = new L.marker([-90000,-90000], {
	icon:icon10}).bindTooltip(" ", 
		    {
        permanent: true, 
        direction: 'right'
    }).addTo(map);
	
	
	
	



var pointA = new L.LatLng(-25.7566505, +28.2783488);
var pointB = new L.LatLng(-25.7566505, +28.2789488);
var pointList = [];

var pointList1 = [];
var pointList2 = [];
var pointList3 = [];
var pointList4 = [];
var pointList5 = [];
var pointList6 = [];
var pointList7 = [];
var pointList8 = [];
var pointList9 = [];
var pointList10 = [];

    
   var bracelets = [];
   var got_response = 0;
    fetch("https://dcs-ems.ngei.csir.co.za:7777/services/core/device/id/all")
    
     .then(response => response.json())
  .then(data => {
	  console.log('Response: ', data);
	  for (var i=0;i<data.length;i++){
	  bracelets[i]= data[i];}
	  got_response = 1;
	  load_data();
  })
  .catch(error => console.error('Error:', error));



console.log("starting ");

// creating all the lines

var firstpolyline = new L.Polyline(pointList, {
    color: 'red',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline.addTo(map);
firstpolyline.remove()
firstpolyline.addTo(map);

var firstpolyline1 = new L.Polyline(pointList, {
    color: '#85144B',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline1.addTo(map);
firstpolyline1.remove()
firstpolyline1.addTo(map);

var firstpolyline2 = new L.Polyline(pointList, {
    color: '#001f3f',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline2.addTo(map);
firstpolyline2.remove()
firstpolyline2.addTo(map);


var firstpolyline3 = new L.Polyline(pointList, {
    color: '#FF5733',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline3.addTo(map);
firstpolyline3.remove()
firstpolyline3.addTo(map);


var firstpolyline4 = new L.Polyline(pointList, {
    color: '#00FFFF',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline4.addTo(map);
firstpolyline4.remove()
firstpolyline4.addTo(map);


var firstpolyline5 = new L.Polyline(pointList, {
    color: '#1c070d',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline5.addTo(map);
firstpolyline5.remove()
firstpolyline5.addTo(map);


var firstpolyline6 = new L.Polyline(pointList, {
    color: '#FFC300',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline6.addTo(map);
firstpolyline6.remove()
firstpolyline6.addTo(map);

var firstpolyline7 = new L.Polyline(pointList, {
    color: '#7FDBFF',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline7.addTo(map);
firstpolyline7.remove()
firstpolyline7.addTo(map);


var firstpolyline8 = new L.Polyline(pointList, {
    color: '#B10DC9',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline8.addTo(map);
firstpolyline8.remove()
firstpolyline8.addTo(map);


var firstpolyline9 = new L.Polyline(pointList, {
    color: '#3D9970',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline9.addTo(map);
firstpolyline9.remove()
firstpolyline9.addTo(map);

var firstpolyline10 = new L.Polyline(pointList, {
    color: '#FF851B',
    weight: 3,
    opacity: 0.5,
    smoothFactor: 1
});
firstpolyline10.addTo(map);
firstpolyline10.remove()
firstpolyline10.addTo(map);





var polygon1;
var polygon2;
var polygon3;

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
var rssiDisplay = document.getElementById("rssi"); 
latv.innerHTML = "waiting for coordinates"; 
// Create a client instance
// client = new Paho.MQTT.Client("broker.hivemq.com", Number(8000), "clientIdWebAppTest");
var clientIdWebApp = "clientIdWebAppTest"+ Math.floor(Math.random() * 10000);  
client = new Paho.MQTT.Client("146.64.8.98", Number(61614), clientIdWebApp);

 
// set callback handlers
client.onConnectionLost = onConnectionLost;
client.onMessageArrived = onMessageArrived;
console.log("before ran");
client.connect({onSuccess:onConnect,userName : "kapua-sys",	password : "kapua-password"});
console.log("connect ran");

// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscppwription and send a message.
  console.log("-------------- onConnect --------------------");
  document.getElementById("start_button").classList.toggle("btn-danger");
  document.getElementById("start_button").classList.toggle("btn-primary");
  document.getElementById("start_button").innerHTML = "Start Monitoring "; 

}

// called when the client loses its connection
function onConnectionLost(responseObject) {

  if (responseObject.errorCode !== 0) {
    console.log("onConnectionLost:"+responseObject.errorMessage);
  }
}

// called when a message arrives
function onMessageArrived(message) {
 			  console.log("onMessageArrived:")
 			  console.log(message);
 			  
 			  // Messaging decoding ---------------------------------------------
 			  var latValue;
			  var longValue;
			  var rssi;	
			  var changeTextDisplay = false;
 			  var payload1 = message.payloadBytes
			  var length = payload1.length;
			  var buffer1 = new ArrayBuffer(length);
			  var message1  = new Uint8Array(buffer1);
			  console.log("onMessageArrived:");
			  var message_recieved_topic = message.destinationName;
			  console.log("topic : ",message_recieved_topic);
			  for (var i=0; i<length; i++) {
				  //message1[(length-1)-i] = payload1[i];
				  message1[i] = payload1[i];
			      //console.log(i+" :"+message1[(length-1)-i] );
			  }


			  protobuf.load("js/kurapayload.proto", function(err1, root) {
				  if (err1){
	 			        throw err1;
	 			       console.log("rinel 0:");
	 			      console.log(err1);
				  }
				  var AwesomeMessage = root.lookupType("kuradatatypes.KuraPayload");
				  
  			

			    
		
			    // Verify the payload if necessary (i.e. when possibly incomplete or invalid)
			    var errMsg = AwesomeMessage.verify(payload1);
			    if (errMsg){
			    	throw Error(errMsg);
			    	console.log("error with verify");
			    }

			    
			    // uncomment to see data
				//console.log(buffer);
				//console.log(message1);
			    // Decode an Uint8Array (browser) or Buffer (node) to a message
			    var message = AwesomeMessage.decode(message1);
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
			    //console.log( object.metric[1].name +": "+object.metric[1].floatValue);
			    //console.log( object.metric[2].name +": "+object.metric[2].floatValue);
				
				var metric_size = object.metric.length;
				console.log( "metric_size = " + metric_size );
				
				for (var i =0 ; i<metric_size;i++){
					if (object.metric[i].name.includes("lat") ){
						latValue = object.metric[i].floatValue;
					}
				if (object.metric[i].name.includes("long") ){
						longValue = object.metric[i].floatValue;
					}
				if (object.metric[i].name.includes("rssi") ){
					rssi = object.metric[i].floatValue;
				    }
				}
				
				 
				
				
				
				  var option1 = document.getElementById("option1");
				  if (option1.checked) {// for tracking single bracelet
									  
									    firstpolyline.addLatLng([latValue, longValue]);
						
									    var newLatLng = new L.LatLng(latValue, longValue);
									    marker.setLatLng(newLatLng); 
									    if (document.getElementById("checkBoxFoll").checked == true){
									    	map.setView([latValue,longValue])
									    }
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
						
									    
							  
							  
						  			
				  }else{//get data for mulitple devices code
					  console.log("Received message for mulitply bracelet"); 
					  console.log(topic_subscribe_bracelet.length);
					  console.log(message_recieved_topic);
					  console.log(topic_subscribe_bracelet[0]);
					  var trackmark = false;
					  var index_recieved = -1;
					  for (var i = 0 ; i < topic_subscribe_bracelet.length; i++){
						  var string_topic = ""+message_recieved_topic;
						  if (string_topic === topic_subscribe_bracelet[i]){
							  index_recieved = topic_subscribe_index[i];
							  console.log("Received message for bracelet: " ,  topic_subscribe_bracelet[i] , " with index " , index_recieved);
							  if (document.getElementById("checkBoxFoll").checked == true){
								  console.log("what to track = " ,  document.getElementById("trackdevice").value); 
								  if (document.getElementById("trackdevice").value === string_topic)
									  {trackmark=true;}
							  }
							  if (document.getElementById("trackdevice").value === string_topic)
							  {changeTextDisplay=true;}
						  }
						  
						  
						  
						  
					  }
					  console.log("bracelet coordinate : lat   " ,  latValue , " | long  " , longValue);
					  if ( (typeof latValue === "undefined") || (typeof longValue === "undefined") )
						  {
						  console.log("Undefined Error on Lat and Long");
						  }else{
							  console.log("Valid Lat and Long values");
							   switch (index_recieved) {
							    case 0:
							    	
							    	  firstpolyline1.addLatLng([latValue, longValue]);
										
									    var newLatLng = new L.LatLng(latValue, longValue);
									    marker1.setLatLng(newLatLng); 
									    marker1.setTooltipContent(document.getElementById("name1").value);
									    if (trackmark){
									    	map.setView([latValue,longValue]);
									    }
									    if (changeTextDisplay){
										    document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[0]+'</b></span>';
										    latv.innerHTML = "Lat = "+ latValue + "";
										    longv.innerHTML = "Long = "+ longValue + "";
										    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    }
									    
							      
							      break;
							    case 1:
							    	
							    	firstpolyline2.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker2.setLatLng(newLatLng); 
								    marker2.setTooltipContent(document.getElementById("name2").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])}
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[1]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";    
								    }
								    
							      
							      break;
							    case 2:
							    	
							    	firstpolyline3.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker3.setLatLng(newLatLng); 
								    marker3.setTooltipContent(document.getElementById("name3").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])}
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[2]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    }
								      
								   break;
							    case 3:
							    	
							    	firstpolyline4.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker4.setLatLng(newLatLng); 
								    marker4.setTooltipContent(document.getElementById("name4").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])}
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[3]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    }
								      
								      break;
							    case 4:
							    	
							    	firstpolyline5.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker5.setLatLng(newLatLng); 
								    marker5.setTooltipContent(document.getElementById("name5").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[4]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
								      
							    case 5:
							    	firstpolyline6.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker6.setLatLng(newLatLng); 
								    marker6.setTooltipContent(document.getElementById("name6").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[5]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
							    case 6:
							    	
							    	firstpolyline7.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker7.setLatLng(newLatLng);
								    marker7.setTooltipContent(document.getElementById("name7").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[6]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
							    case 7:
							    	
							    	firstpolyline8.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker8.setLatLng(newLatLng); 
								    marker8.setTooltipContent(document.getElementById("name8").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[7]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
								      
							    case 8:
							    	
							    	firstpolyline9.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker9.setLatLng(newLatLng); 
								    marker9.setTooltipContent(document.getElementById("name9").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[8]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
							    case 9:
							    	
							    	firstpolyline10.addLatLng([latValue, longValue]);
									
								    var newLatLng = new L.LatLng(latValue, longValue);
								    marker10.setLatLng(newLatLng); 
								    marker10.setTooltipContent(document.getElementById("name10").value);
								    if (trackmark){
								    	map.setView([latValue,longValue])
								    }
								    if (changeTextDisplay){
								    	document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[9]+'</b></span>';
									    latv.innerHTML = "Lat = "+ latValue + "";
									    longv.innerHTML = "Long = "+ longValue + "";
									    rssiDisplay.innerHTML = "RSSI = "+ rssi + "";}
								      
								      break;
							    default:
							      console.log("Received message on unknown topic: " + message.destinationName);
							  } 
				  		
					  
						  }
					  				
				  }
				
				
				
				
				
				
				
				
				
				
				
				
			  });
 			  // Messaging decoding end -----------------------------------------
 			  
 			  
			
			



  
}


function start_topic(){
	 var innerHTML = "|&nbsp;&nbsp;";
	 var option1 = document.getElementById("option1");
	  if (option1.checked) {// for tracking single bracelet

			var topic = "kapua-sys/"+document.getElementById("inputTopic").value+"/data"
			console.log("topic : "+topic);
			client.subscribe(topic);
			setTimeout(function(){
				polygon1 = new L.polygon([
					[ -25.756668,28.273927],
					[-25.757001,28.273962 ],
					[-25.756914, 28.275088 ],
					[-25.756806,28.275689],
					[ -25.756335,28.275461],
					[-25.756668, 28.273927 ]
			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 1500); 	
		
			
			
			setTimeout(function(){
				polygon2 = new L.polygon([
					[-25.754139,28.276043],
					[-25.755482,28.276011],
					[-25.755975,28.27629],
					[-25.756458,28.277041],
					[-25.757327,28.277051],
					[-25.758767,28.277094],
					[-25.758912,28.278907],
					[-25.75697,28.282092],
					[-25.754216,28.281802],
					[-25.749404,28.283669],
					[-25.747683,28.284441],
					[-25.744601,28.282167],
					[-25.742078,28.282725],
					[-25.74155,28.282537],
					[-25.74112,28.278086],
					[-25.74097,28.276226],
					[-25.74731,28.275073],
					[-25.74988,28.274085],
					[-25.752494,28.2746],
					[-25.754139,28.276043]
			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 2000); 
			
			setTimeout(function(){
				polygon3 = new L.polygon([
					[ -25.765578,28.273908],
					[-25.768399,28.273473 ],
					[-25.778065,28.270363 ],
					[-25.779152,28.270347 ],
					[-25.780152,28.273366 ],
					[-25.765954,28.277163 ],
					[-25.765578,28.273908 ]
			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 2500); 
			
			console.log("subscribtion done");
	  }else{// for multiple bracelets
		  var count_for_index = 0;
	  	 
		  for (var i = 0 ; i <10 ; i++){
			  var id_string_checkbox = "checkbox"+(i+1);
			  var id_string_bracelet = "bracelet"+(i+1);
			  var checkbox_check = document.getElementById(id_string_checkbox);
			  if (checkbox_check.checked){
				  
				  var topic = "kapua-sys/"+document.getElementById(id_string_bracelet).value+"/data" 
				  topic_subscribe_index[count_for_index] = i;
				  topic_subscribe_bracelet[count_for_index] = topic;
				  topic_subscribe_bracelet_name[count_for_index] = document.getElementById(id_string_bracelet).value;
				  client.subscribe(topic);  
				  console.log("subscribtion to - ",topic);
				  
				  //adding list to the following list select input
				  follow_list = document.getElementById('trackdevice');
				  myOption = document.createElement("option");
				  myOption.text =document.getElementById(id_string_bracelet).value;
				  myOption.value = topic;
				  follow_list.appendChild(myOption);
				  innerHTML = innerHTML + '<img src="'+icon_list_url[i]+'"  width= "15px;" > - '+document.getElementById(id_string_bracelet).value+'&nbsp;&nbsp;|&nbsp;&nbsp;' ;
				  
				  
			  }
			  count_for_index = count_for_index + 1; 
			  
			  
		  }
		  console.log("innerHTML - ",innerHTML);
		  document.getElementById("keyofmarker").innerHTML = innerHTML;
	  
		  setTimeout(function(){
				polygon1 = new L.polygon([
					[ -25.756668,28.273927],
					[-25.757001,28.273962 ],
					[-25.756914, 28.275088 ],
					[-25.756806,28.275689],
					[ -25.756335,28.275461],
					[-25.756668, 28.273927 ]
			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 1500); 	
		
			
			
			setTimeout(function(){
				polygon2 = new L.polygon([
					[-25.754139,28.276043],
					[-25.755482,28.276011],
					[-25.755975,28.27629],
					[-25.756458,28.277041],
					[-25.757327,28.277051],
					[-25.758767,28.277094],
					[-25.758912,28.278907],
					[-25.75697,28.282092],
					[-25.754216,28.281802],
					[-25.749404,28.283669],
					[-25.747683,28.284441],
					[-25.744601,28.282167],
					[-25.742078,28.282725],
					[-25.74155,28.282537],
					[-25.74112,28.278086],
					[-25.74097,28.276226],
					[-25.74731,28.275073],
					[-25.74988,28.274085],
					[-25.752494,28.2746],
					[-25.754139,28.276043]

			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 2000); 
			
			setTimeout(function(){
				polygon3 = new L.polygon([
					[ -25.765578,28.273908],
					[-25.768399,28.273473 ],
					[-25.778065,28.270363 ],
					[-25.779152,28.270347 ],
					[-25.780152,28.273366 ],
					[-25.765954,28.277163 ],
					[-25.765578,28.273908 ]
			],{
				    color: 'blue',
				    weight: 3,
				    opacity: 0.5,
				    smoothFactor: 1
				}).addTo(map);
			}, 2500); 
			console.log("subscribtion done");
			  
		  
		  
	  
		  
	  }
	  document.getElementById("start_button").classList.toggle("btn-primary");
	  document.getElementById("start_button").classList.toggle("btn-success");
	
}


</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRmSBAJbhVk0EZ7h9DF4iY4SZzQPcuqrA&callback=myMap"></script>


</html>