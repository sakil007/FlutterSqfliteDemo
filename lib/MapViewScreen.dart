
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapViewScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapViewScreen();
  }

}

class _MapViewScreen extends State<MapViewScreen>{
  Completer<GoogleMapController> _controller = Completer();
  PermissionStatus _permissionGranted;
  Location location = new Location();
  bool _serviceEnabled;
  LocationData currentLocation;
  String speeed;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.5726, 88.3639),
    zoom: 25.4746,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLocationPermission();
    location.onLocationChanged.listen((LocationData locationData) async {
      this.currentLocation=locationData;
      speeed=locationData.speed.toString();

      /*final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 25.4746,
      )));*/
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
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      body: Container(
        child:  GoogleMap(
          mapType: MapType.satellite,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

}