import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoder2/geocoder2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:ssnvisitapp/navigation_screen.dart';
import 'itdetails.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Maps(),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      useMaterial3: true,
    ),
  ));
}

class Maps extends StatefulWidget {
  @override
  State<Maps> createState() => _MyAppState();
}

class CustomMarker {
  final String name;
  final LatLng position;

  CustomMarker({required this.name, required this.position});
}

class _MyAppState extends State<Maps> {
  LatLng? destLocation = LatLng(12.750875, 80.197273);
  Location location = Location();
  LocationData? _currentPosition;
  final Completer<GoogleMapController> _controller = Completer();
  String? _address;
  List<CustomMarker> staticMarkers = [
    CustomMarker(name: 'IT Department Block', position: LatLng(12.7513923, 80.1962365)),
  ];

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('SSN Campus'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigate_next),
          onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (context) => NavigationScreen(destLocation!.latitude, destLocation!.longitude)),
                  (route) => false);
          }),
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: destLocation!,
                zoom:16
              ),
            onCameraMove: (CameraPosition? position){
              if (destLocation != position!.target) {
                setState((){
                  destLocation = position.target;
                });
              }
            },
            onCameraIdle: () {
              print('camera idle');
              getAddressFromLatLng();
            },
            onTap: (latLng) {
              print(latLng);
            },
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
            markers: Set.from(staticMarkers.map((marker) => Marker(
              markerId: MarkerId(marker.name),
              position: marker.position,
              infoWindow: InfoWindow(title: marker.name),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>itDept()),
                );
                // print('Marker ${marker.name} clicked!');
              },
            ))),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 35.0),
              child: Image.asset(
                'assets/images/pick.jpg',
                height:40,
                width:40,
              ),
            ),
          ),
          Positioned(
            top: 40,
              right: 20,
              left:20,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(20),
                child: Text(_address ?? 'Pick your destination address',
                overflow: TextOverflow.visible, softWrap: true),
            ),
          ),
        ],
      ),
    );
  }

  getAddressFromLatLng() async {
    try{
      GeoData data = await Geocoder2.getDataFromCoordinates(
          latitude: destLocation!.latitude,
          longitude: destLocation!.longitude,
          googleMapApiKey: 'AIzaSyBuB2agxSrHoLeD8Eg43I-3XgEDX43SzB4');
      setState((){
        _address = data.address;
      });
    } catch (e) {
      print(e);
    }
  }

  getCurrentLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    final GoogleMapController? controller = await _controller.future;

    if (_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (_permissionGranted == PermissionStatus.granted)
      {
        location.changeSettings(accuracy: LocationAccuracy.high);
        _currentPosition= await location.getLocation();
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!), zoom: 16,)));
        setState(() {
          destLocation = LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
        });
      }
  }
}