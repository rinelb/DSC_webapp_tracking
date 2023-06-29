
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
<img src ="img/cropped-newnew.png" width="150" height="60" />  <span style="font-size:50px;">&nbsp; Geo Tracker</span></h1><br>
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
						</select>  &nbsp; <input type="checkbox" id="checkbox1" > &nbsp; <input type="text" id="name1" value="Robben Arjen" >&nbsp;<img id="status1" src=""/> <br>
						<select id = "bracelet2" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox2"  >&nbsp; <input type="text" id="name2" value="Zidane Zinedine" >&nbsp;<img id="status2"/><br>
						<select id = "bracelet3" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox3">&nbsp; <input type="text" id="name3" value="Moreira	Ronaldinho">&nbsp;<img id="status3"/><br>
						<select id = "bracelet4" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox4" >&nbsp; <input type="text" id="name4" value="Modric Luka">&nbsp;<img id="status4"/><br>
						<select id = "bracelet5" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox5" >&nbsp; <input type="text" id="name5" value="Ibrahimovic Zlatan">&nbsp;<img id="status5"/><br>
						<select id = "bracelet6" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox6" >&nbsp; <input type="text" id="name6" value="Messi Lionel">&nbsp;<img id="status6"/><br>
						<select id = "bracelet7" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox7" >&nbsp; <input type="text" id="name7" value="da Silva Santos Neymar Jr.">&nbsp;<img id="status7"/><br>
						<select id = "bracelet8" onchange = "favTutorial()" >  
						</select> &nbsp; <input type="checkbox" id="checkbox8" >&nbsp; <input type="text" id="name8" value="dos Santos Aveiro Ronaldo">&nbsp;<img id="status8"/><br>
						<select id = "bracelet9" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox9" >&nbsp; <input type="text" id="name9" value="Mbappe Kylian">&nbsp;<img id="status9"/><br>
						<select id = "bracelet10" onchange = "favTutorial()" >  
						</select>  &nbsp; <input type="checkbox" id="checkbox10" >&nbsp; <input type="text" id="name10" value="Drogba Didier">&nbsp;<img id="status10"/><br><br>
						<button type="button" class="btn btn-primary" id="hideSettingGui" onclick="Hide_setting()">Show Setting</button>
						<div id="setting" style="display:none"> 
							Active Time 
							<img src="img/green.png"/> less than <input type="number" id="numberGreen" value=60000> millsec <br> <img src="img/yellow.png"/> less than <input type="number" id="numberYellow" value=300000> millsec <br> 
							<img src="img/red.png"/> for longer  <br>   <img src="img/grey.png"/> means no message was received yet
							<hr>
							Battery  
							<img src="img/green.png"/> great than <input type="number" id="batteryg" value=4.0 step="0.01"> volts <br> <img src="img/yellow.png"/> greater than <input type="number" id="batteryy" value=3.5 step="0.01"> volts <br> 
							<img src="img/red.png"/> for lower  <br>  
							<hr>
							RSSI  
							<img src="img/green.png"/> higher than <input type="float" id="rssig" value=-90> db <br> <img src="img/yellow.png"/> higher than <input type="float" id="rssiy" value=-100 > db <br> 
							<img src="img/red.png"/> for lower  <br>  
							<hr>  
							<img src="img/green.png"/> No tamper  |  <img src="img/red.png"/> tamper detected  <br>  
							<hr>
							Temp  
							<img src="img/green.png"/> lower than <input type="number" id="tempg" value=30.0 step="0.01"> Deg C <br> <img src="img/yellow.png"/> lower than <input type="number" id="tempy" value=50.0 step="0.01" > Deg C <br> 
							<img src="img/red.png"/> for higher  <br>  
							<hr>
							speed  
							<img src="img/red.png"/> faster than <input type="float" id="speedr" value=10> meter/s <br> <img src="img/yellow.png"/> higher than <input type="float" id="speedy" value=5 > m/s <br> 
							<img src="img/green.png"/> for slower  <br>  
					  	</div>
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
				<table id="table">
					<thead style="bold;">
						<td>Device</td>
						<td>Time</td>
						<td>RSSI</td>
						<td>Battery</td>
						<td>Temp</td>
						<td>Tamper</td>
						<td>Speed</td>
						
					</thead>
					<tr>
						<td id="r1d1"></td>
						<td id="r1d2"></td>
						<td id="r1d3"></td>
						<td id="r1d4"></td>
						<td id="r1d5"></td>
						<td id="r1d6"></td>
						<td id="r1d7"></td>
						
					</tr>
					
					<tr>
						<td id="r2d1"></td>
						<td id="r2d2"></td>
						<td id="r2d3"></td>
						<td id="r2d4"></td>
						<td id="r2d5"></td>
						<td id="r2d6"></td>
						<td id="r2d7"></td>
						
					</tr>
					<tr>
						<td id="r3d1"></td>
						<td id="r3d2"></td>
						<td id="r3d3"></td>
						<td id="r3d4"></td>
						<td id="r3d5"></td>
						<td id="r3d6"></td>
						<td id="r3d7"></td>
						
					</tr>
					<tr>
						<td id="r4d1"></td>
						<td id="r4d2"></td>
						<td id="r4d3"></td>
						<td id="r4d4"></td>
						<td id="r4d5"></td>
						<td id="r4d6"></td>
						<td id="r4d7"></td>
						
					</tr>
					<tr>
						<td id="r5d1"></td>
						<td id="r5d2"></td>
						<td id="r5d3"></td>
						<td id="r5d4"></td>
						<td id="r5d5"></td>
						<td id="r5d6"></td>
						<td id="r5d7"></td>
						
					</tr>
					<tr>
						<td id="r6d1"></td>
						<td id="r6d2"></td>
						<td id="r6d3"></td>
						<td id="r6d4"></td>
						<td id="r6d5"></td>
						<td id="r6d6"></td>
						<td id="r6d7"></td>
						
					</tr>
					<tr>
						<td id="r7d1"></td>
						<td id="r7d2"></td>
						<td id="r7d3"></td>
						<td id="r7d4"></td>
						<td id="r7d5"></td>
						<td id="r7d6"></td>
						<td id="r7d7"></td>
					
					</tr>
					<tr>
						<td id="r8d1"></td>
						<td id="r8d2"></td>
						<td id="r8d3"></td>
						<td id="r8d4"></td>
						<td id="r8d5"></td>
						<td id="r8d6"></td>
						<td id="r8d7"></td>
						
					</tr>
					<tr>
						<td id="r9d1"></td>
						<td id="r9d2"></td>
						<td id="r9d3"></td>
						<td id="r9d4"></td>
						<td id="r9d5"></td>
						<td id="r9d6"></td>
						<td id="r9d7"></td>
						
					</tr>
					<tr>
						<td id="r10d1"></td>
						<td id="r10d2"></td>
						<td id="r10d3"></td>
						<td id="r10d4"></td>
						<td id="r10d5"></td>
						<td id="r10d6"></td>
						<td id="r10d7"></td>
						
					</tr>
				</table>
				
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
  
Hide_setting

function Hide_setting() {  
	if (document.getElementById("hideSettingGui").innerHTML === "Hide Setting"){
		document.getElementById("hideSettingGui").innerHTML = "Show Setting"
		document.getElementById("setting").style.display = "none";
	}else{
		document.getElementById("hideSettingGui").innerHTML = "Hide Setting";
		document.getElementById("setting").style.display = "block";
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

var ranOnceZone = true;

var time1b=0;
var time2b=0;
var time3b=0;
var time4b=0;
var time5b=0;
var time6b=0;
var time7b=0;
var time8b=0;
var time9b=0;
var time10b=0;
var greenColor = "#B1F77B";
var yellowColor ="#FFFD5E";
var redColor ="#FF8383";




function statusCheck () {
    console.log('statusCheck --------');
    var currentTime = new Date().getTime();
    console.log("currentTime " ,  currentTime); 
    var intervalGreen = document.getElementById("numberGreen").value;
    var intervalYellow =  document.getElementById("numberYellow").value;
    var rssiGreen = parseFloat(document.getElementById("rssig").value).toFixed(2);
    var rssiYellow =  parseFloat(document.getElementById("rssiy").value).toFixed(2);
    var batteryGreen = document.getElementById("batteryg").value;
    var batteryYellow =  document.getElementById("batteryy").value;
    for (var i = 0;i<10;i++){
    		var indexString = "checkbox" + (i+1);
    		var indexImag = "status"+(i+1);
    		console.log('document.getElementById(indexString).checked  ', document.getElementById(indexString).checked);
		    if (document.getElementById(indexString).checked == true){
		    	
				  switch (i){
				  		case 0:
				  			var tempCompareTime =  (currentTime )  - (time1b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time1b ",time1b , );
				  			if (time1b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  			
						case 1:
				  			var tempCompareTime =  (currentTime )  - (time2b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time2b ",time2b , );
				  			if (time2b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
						case 2:
				  			var tempCompareTime =  (currentTime )  - (time3b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time3b ",time3b , );
				  			if (time3b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
						case 3:
				  			var tempCompareTime =  (currentTime )  - (time4b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time4b ",time4b , );
				  			if (time4b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
						case 4:
				  			var tempCompareTime =  (currentTime )  - (time5b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time5b ",time5b , );
				  			if (time5b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
						case 5:
				  			var tempCompareTime =  (currentTime )  - (time6b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time7b ",time6b , );
				  			if (time6b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  			
						case 6:
				  			var tempCompareTime =  (currentTime )  - (time7b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time7b ",time7b , );
				  			if (time7b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  			
						case 7:
				  			var tempCompareTime =  (currentTime )  - (time8b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time8b ",time8b , );
				  			if (time8b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  			
						case 8:
				  			var tempCompareTime =  (currentTime )  - (time9b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time1b ",time9b , );
				  			if (time9b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  			
						case 9:
				  			var tempCompareTime =  (currentTime )  - (time10b  );
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time10b ",time10b , );
				  			if (time10b==0){
				  				document.getElementById(indexImag).src = "img/grey.png";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById(indexImag).src = "img/green.png";
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById(indexImag).src = "img/yellow.png";
				  				console.log("YELLLLOOOOWWW ");

				  				
				  			}else{
				  				document.getElementById(indexImag).src = 'img/red.png';
				  				console.log("REEEEEEDDDD ");

				  					
				  			}
				  			 
				  			break;
				  		
				  			
				  		
				  			
				  }
				  
			  }
    }
    
    console.log('End statusCheck --------'); 
}




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
//latv.innerHTML = "waiting for coordinates"; 
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
  document.getElementById("start_button").innerHTML = "Monitoring Start"; 

}

// called when the client loses its connection
function onConnectionLost(responseObject) {

  if (responseObject.errorCode !== 0) {
    console.log("onConnectionLost:"+responseObject.errorMessage);
  }
}

// called when a message arrives
function onMessageArrived(message) {
	
	 var intervalGreen = document.getElementById("numberGreen").value;
	    var intervalYellow =  document.getElementById("numberYellow").value;
	    var rssiGreen = document.getElementById("rssig").value;
	    var rssiYellow =  document.getElementById("rssiy").value;
	    var batteryGreen = document.getElementById("batteryg").value;
	    var batteryYellow =  document.getElementById("batteryy").value;
	    var speedRed = document.getElementById("speedr").value;
	    var speedYellow = document.getElementById("speedy").value;
	    var temperatureGreen = document.getElementById("tempg").value;
	    var temperatureYellow = document.getElementById("tempy").value;
	    
 			  console.log("onMessageArrived:")
 			  console.log(message);
 			  
 			  // Messaging decoding ---------------------------------------------
 			  var latValue;
			  var longValue;
			  var rssi;	
			  var battery;
			  var tamper;
			  var temperature;
			  var speed;
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
			    var timestampRecord = object.timestamp; //used to store timestamp for checking last sent
			    displayTheTimeValue = d;
			    console.log("timestampRecord ",timestampRecord);
			    
			    //console.log( object.metric[1].name +": "+object.metric[1].floatValue);
			    //console.log( object.metric[2].name +": "+object.metric[2].floatValue);
				
				var metric_size = object.metric.length;
				console.log( "metric_size = " + metric_size );
				var stringMatricName = "";
				for (var i =0 ; i<metric_size;i++){
					stringMatricName = stringMatricName + object.metric[i].name + " \n " 
					if (object.metric[i].name.includes("lat") ){
						latValue = object.metric[i].floatValue;
					}
				if (object.metric[i].name.includes("long") ){
						longValue = object.metric[i].floatValue;
					}
				if (object.metric[i].name.includes("rssi") ){
					rssi = object.metric[i].floatValue;
				    }
				if (object.metric[i].name.includes("rssi") ){
					battery = object.metric[i].floatValue;
				    }
				if (object.metric[i].name.includes("temperature") ){
					temperature = object.metric[i].floatValue;
					console.log("temperature: "+temperature);
				    }
				if (object.metric[i].name.includes("speed") ){
					speed = object.metric[i].doubleValue;
					console.log("speed: "+speed);
				    }
				if (object.metric[i].name.includes("tamper") ){
					tamper = object.metric[i].boolValue;
					console.log("tamper: "+tamper);
				    }
				
				temperature
				}
				console.log("stringMatricName: "+stringMatricName);
				
				
				
				
				
				 
				
				
				
				  var option1 = document.getElementById("option1");
				  if (option1.checked) {// for tracking single bracelet
									  
									    firstpolyline.addLatLng([latValue, longValue]);
						
									    var newLatLng = new L.LatLng(latValue, longValue);
									    marker.setLatLng(newLatLng); 
									    if (document.getElementById("checkBoxFoll").checked == true){
									    	map.setView([latValue,longValue])
									    }
									    
						
									    
							  
							  
						  			
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
					  
					  switch (index_recieved) {
					    case 0:
					    	
					    	document.getElementById("r1d1").innerHTML = "<b>"+ document.getElementById("name1").value +"</b>"+ " - " + topic_subscribe_bracelet_name[0];
					    	
					    	time1b = timestampRecord;
					    	currentTime = new Date().getTime();
					    	var tempCompareTime =  (currentTime )  - (time1b  );
					    	var dt1 = new Date(0);
					    	dt1.setUTCSeconds((object.timestamp)/1000);
					    	var hrs = dt1.getHours();
					    	var mins = dt1.getMinutes();
					    	var hhmm = (hrs < 10 ? "0" + hrs : hrs) + ":" + (mins < 10 ? "0" + mins : mins);
				  			console.log("tempCompareTime ", tempCompareTime,"  currentTime " ,  currentTime,"  time1b ",time1b , );
				  			if (time1b==0){
				  				document.getElementById("r1d2").innerHTML = "-";
				  			}else
				  			if (tempCompareTime < intervalGreen){
				  				document.getElementById("r1d2").style.backgroundColor = greenColor;
				  				
				  				var displayThisTime = hhmm;
				  				document.getElementById("r1d2").innerHTML = displayThisTime;
				  				console.log("GREEEEEEEN ");
				  			}else if(tempCompareTime < intervalYellow){
				  				document.getElementById("r1d2").style.backgroundColor = yellowColor;
				  				console.log("YELLLLOOOOWWW ");
				  				var dt1 = new Date((time1b)/1000); // The 0 there is the key, which sets the date to the epoch
				  				
				  				var displayThisTime = hhmm;
				  				document.getElementById("r1d2").innerHTML = displayThisTime;

				  				
				  			}else{
				  				document.getElementById("r1d2").style.backgroundColor = redColor;
				  				console.log(dt1);
				  				
				  				var displayThisTime = hhmm;
				  				document.getElementById("r1d2").innerHTML = displayThisTime;
				  					
				  			}
				  			document.getElementById("r1d3").innerHTML = rssi;
				  			console.log("rssi ", rssi,"  rssiGreen " ,  rssiGreen);
				  			
				  			if (rssi > rssiGreen)
				  				{
				  				document.getElementById("r1d3").style.backgroundColor = greenColor;
				  				}else if (rssi >= rssiYellow)
				  					{	
				  						document.getElementById("r1d3").style.backgroundColor = yellowColor;
				  					
				  					}else{
				  						document.getElementById("r1d3").style.backgroundColor = redColor;
				  					}
				  			
				  			document.getElementById("r1d4").innerHTML = rssi;
				  			if (battery > batteryGreen)
				  				{
				  				document.getElementById("r1d4").style.backgroundColor = greenColor;
				  				}else if (battery >= batteryYellow)
				  					{	
				  						document.getElementById("r1d4").style.backgroundColor = yellowColor;
				  					
				  					}else{
				  						document.getElementById("r1d4").style.backgroundColor = redColor;
				  					}
				  			
				  			document.getElementById("r1d5").innerHTML = temperature;
				  			console.log("temperature ", temperature,"  temperatureGreen " ,  temperatureGreen);
				  			if (temperature < (temperatureGreen))
				  				{
				  				document.getElementById("r1d5").style.backgroundColor = greenColor;
				  				}else if (temperature < temperatureYellow)
				  				{	
				  						document.getElementById("r1d5").style.backgroundColor = yellowColor;
				  					
				  				}else{
				  						document.getElementById("r1d5").style.backgroundColor = redColor;
				  				}
				  			
				  			document.getElementById("r1d6").innerHTML = tamper;
				  			if (tamper)
				  				{
				  				document.getElementById("r1d6").style.backgroundColor = redColor;
				  				
				  				}else{
				  						document.getElementById("r1d6").style.backgroundColor = greenColor;
				  				}
				  			
				  			document.getElementById("r1d7").innerHTML = speed;
				  			if (speed > speedRed)
				  				{
				  				document.getElementById("r1d7").style.backgroundColor = redColor;
				  				}else if (speed > speedYellow)
				  				{	
				  						document.getElementById("r1d7").style.backgroundColor = yellowColor;
				  					
				  				}else{
				  						document.getElementById("r1d7").style.backgroundColor = greenColor;
				  				}
					    	
				  			
				  			
					    	
					    	
					    	break;
					    case 1:
					    	time2b = timestampRecord;
					    	break;
					    case 2:
					    	time3b = timestampRecord;
					    	break;
					    case 3:
					    	time4b = timestampRecord;
					    	break;
					    case 4:
					    	time5b = timestampRecord;
					    	break;
					    case 5:
					    	time6b = timestampRecord;
					    	break;
					    case 6:
					    	time7b = timestampRecord;
					    	break;
					    case 7:
					    	time8b = timestampRecord;
					    	break;
					    case 8:
					    	time9b = timestampRecord;
					    	break;
					    case 9:
					    	time10b = timestampRecord;
					    	break;
					  }
					  console.log("timestampRecord ",timestampRecord);
					    	
					  
					  
					  console.log("bracelet coordinate : lat   " ,  latValue , " | long  " , longValue);
					  if ( (typeof latValue === "undefined") || (typeof longValue === "undefined") )
						  {
						  console.log("Undefined Error on Lat and Long");
						  }else{
							  console.log("Valid Lat and Long values");
							  var tempindex_recieved = 11
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
										    //document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[0]+'</b></span>';
										    //latv.innerHTML = "Lat = "+ latValue + "";
										    //longv.innerHTML = "Long = "+ longValue + "";
										    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
										    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
										    //time1b = timestampRecord;
										    console.log("timestampRecord ",timestampRecord);
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[1]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									   // time2b = timestampRecord;
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[2]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									   // time3b = timestampRecord;
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[3]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue
									   // time4b = timestampRecord;
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[4]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									   // time5b = timestampRecord;
									    }
								      
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[5]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									//time6b = timestampRecord;
									    }
								      
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[6]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									  //  time7b = timestampRecord;
									    }
								      
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[7]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue; 
									//    time8b = timestampRecord;
								    }
								      
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[8]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;    
									 //   time9b = timestampRecord;
								    }
								      
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
								    	//document.getElementById("bracelet_lat_long").innerHTML = '<span style="font-size: 36px;"><b>'+topic_subscribe_bracelet_name[9]+'</b></span>';
									    //latv.innerHTML = "Lat = "+ latValue + "";
									    //longv.innerHTML = "Long = "+ longValue + "";
									    //rssiDisplay.innerHTML = "RSSI = "+ rssi + "";
									    
									    //timeDisplay.innerHTML = "Time = "+ displayTheTimeValue;
									 //   time10b = timestampRecord;
									   }
								      
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
	 var interval = setInterval(function () { statusCheck(); }, 10000);
	 
				  if (option1.checked) {// for tracking single bracelet
			
						var topic = "kapua-sys/"+document.getElementById("inputTopic").value+"/data"
						console.log("topic : "+topic);
						client.subscribe(topic);
						 if (ranOnceZone){
						setTimeout(function(){
							polygon1 = new L.polygon([
								[-25.754018,28.276449],
								[-25.754187,28.275701],
								[-25.754388,28.27469],
								[-25.755202,28.274848],
								[-25.755644,28.27491],
								[-25.755482,28.276296],
								[-25.754018,28.276449]
						],{
							    color: 'blue',
							    weight: 3,
							    opacity: 0.5,
							    smoothFactor: 1
							}).addTo(map);
						}, 1500); 	
					
						
						
						setTimeout(function(){//csir
							polygon2 = new L.polygon([
								[-25.752552,28.277133],
								[-25.753298,28.277055],
								[-25.75402,28.277004],
								[-25.754489,28.276964],
								[-25.754849,28.27691],
								[-25.755088,28.276897],
								[-25.755697,28.276833],
								[-25.756499,28.276573],
								[-25.757753,28.275672],
								[-25.758303,28.275608],
								[-25.759052,28.277222],
								[-25.759608,28.278404],
								[-25.759581,28.279769],
								[-25.759105,28.280772],
								[-25.757492,28.2827],
								[-25.755243,28.285277],
								[-25.752742,28.282898],
								[-25.751812,28.278573],
								[-25.752552,28.277133]
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
				  }
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
							   
							  var tempName = "name" + (i+1);
							  console.log("tempName - ",tempName);
							  var display_text_focus =  document.getElementById(tempName).value;
							  
							  
							  client.subscribe(topic);  
							  console.log("subscribtion to - ",topic);
							  
							  //adding list to the following list select input
							  follow_list = document.getElementById('trackdevice');
							  myOption = document.createElement("option");
							  //myOption.text =document.getElementById(id_string_bracelet).value;
							  myOption.text = display_text_focus;
							  myOption.value = topic;
							  follow_list.appendChild(myOption);
							  innerHTML = innerHTML + '<img src="'+icon_list_url[i]+'"  width= "15px;" > - '+document.getElementById(id_string_bracelet).value+'&nbsp;&nbsp;|&nbsp;&nbsp;' ;
							  
							  
						  }
						  count_for_index = count_for_index + 1; 
						  
						  
					  }
					  console.log("innerHTML - ",innerHTML);
					  document.getElementById("keyofmarker").innerHTML = "";
					  if (ranOnceZone){
					  setTimeout(function(){
							polygon1 = new L.polygon([
								[-25.754018,28.276449],
								[-25.754187,28.275701],
								[-25.754388,28.27469],
								[-25.755202,28.274848],
								[-25.755644,28.27491],
								[-25.755482,28.276296],
								[-25.754018,28.276449]
						],{
							    color: 'blue',
							    weight: 3,
							    opacity: 0.5,
							    smoothFactor: 1
							}).addTo(map);
						}, 1500); 	
					
						
						
						setTimeout(function(){//csir
							polygon2 = new L.polygon([
								[-25.752552,28.277133],
								[-25.753298,28.277055],
								[-25.75402,28.277004],
								[-25.754489,28.276964],
								[-25.754849,28.27691],
								[-25.755088,28.276897],
								[-25.755697,28.276833],
								[-25.756499,28.276573],
								[-25.757753,28.275672],
								[-25.758303,28.275608],
								[-25.759052,28.277222],
								[-25.759608,28.278404],
								[-25.759581,28.279769],
								[-25.759105,28.280772],
								[-25.757492,28.2827],
								[-25.755243,28.285277],
								[-25.752742,28.282898],
								[-25.751812,28.278573],
								[-25.752552,28.277133]
			
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
					  
					  
				  
				
				  ranOnceZone = false;
	 }
	  document.getElementById("start_button").classList.toggle("btn-primary");
	  document.getElementById("start_button").classList.toggle("btn-success");
	
}


</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRmSBAJbhVk0EZ7h9DF4iY4SZzQPcuqrA&callback=myMap"></script>


</html>