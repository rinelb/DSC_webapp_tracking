<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.min.js" type="text/javascript"></script>
<script src="https://cdn.rawgit.com/dcodeIO/protobuf.js/6.8.8/dist/protobuf.js"></script> 
<body>
<h1>Rinel</h1>
<p id="lat"></p>
<p id="long"></p>
</body>

<script>

var latv = document.getElementById("lat"); 
var longv = document.getElementById("long"); 
latv.innerHTML = "hhhh"; 
// Create a client instance
client = new Paho.MQTT.Client("broker.hivemq.com", Number(8000), "clientIdWebAppTest");
 
// set callback handlers
client.onConnectionLost = onConnectionLost;
client.onMessageArrived = onMessageArrived;
console.log("before ran");
// connect the client
client.connect({onSuccess:onConnect,userName : "kapua-sys",	password : "kapua-password"});
// client.loop_forever();
console.log("connect ran");
// called when the client connects
function onConnect() {
  // Once a connection has been made, make a subscppwription and send a message.
  console.log("onConnect");
  client.subscribe("kapua-sys/NRF123456789/data");
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
			    console.log( object.metric[0].name +": "+object.metric[0].doubleValue);
			    console.log( object.metric[1].name +": "+object.metric[1].doubleValue);
			    
			    latv.innerHTML = "lat = "+ object.metric[0].doubleValue + "";
			    longv.innerHTML = "long = "+ object.metric[1].doubleValue + "";
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




</script>

</html>