import 'dart:async';  

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
   @override
   State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  Map<String,double> currentLocation = new Map();
  StreamSubscription<Map<String,double>> locationSubscription;

  Location location = new Location();
  String error;

  @override
  void initState() {
   super.initState();

   currentLocation['latitude']= 0.0;
   currentLocation['longitude']= 0.0;
   
  initPlatFormState();
  locationSubscription = location.onLocationChanged.listen((Map<String, double> result){
    setState(() {
      currentLocation = result;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
     home: new Scaffold(
      appBar: AppBar(title: Text('LOCATION'),),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Lat/Long: ${currentLocation['latitude']}/${currentLocation['latitude']}',
            style: TextStyle(fontSize: 20.0, color: Colors.blueAccent),)
            ],)
            ,),
     ) );

}  
void initPlatFormState() async{
     Map<String, double> my_location;
     try{
       my_location = (location.getLocation) as Map<String, double>;
       error = "";
     }on PlatformException catch(e){
       if(e.code == 'PERMISSION DENIED')
         error = 'Permission Denied';
       else if(e.code == 'PERMISSION_DENIED_NEVER_ASK')
         error = 'Permission Denied - Please enable';
       my_location = null;
     }
    setState(() {
      currentLocation = my_location;
    });
    }
    
   
}