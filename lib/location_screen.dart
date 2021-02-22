import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _locationScreen();
  }


}

class _locationScreen extends State<LocationScreen>{
  PermissionStatus _permissionGranted;
  Location location = new Location();
  bool _serviceEnabled;
  LocationData currentLocation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocationPermission();

    location.onLocationChanged.listen((LocationData currentLocation) {
      this.currentLocation=currentLocation;
      setState(() {

      });
    });
  }

  Future<void> turnonLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();

      }
    }
  }
  Future<void> getLocationPermission() async {
    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }else{
        turnonLocation();
      }
    }else if(_permissionGranted== PermissionStatus.granted){
      turnonLocation();
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
         appBar: AppBar(title: Text("Location class"),),
      body: Container(
        child: Center(
          child: Text(currentLocation.longitude.toString()+"======="+currentLocation.latitude.toString()),
        ),
      ),
    );
  }

}