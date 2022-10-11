import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:places_app/helpers/location_helper.dart';
import 'package:places_app/model/place.dart';
import 'package:places_app/screens/maps_screen.dart';

class LocationInput extends StatefulWidget{
  static LatLng? _location;
  @override
  State<LocationInput> createState() {
    // TODO: implement createState
    return LocationState();
  }
  void _setLocation(LatLng location){
    _location = location;
  }
  static LatLng getUserSelectedLocation(){
    return _location!;
  }
}
class LocationState extends State<LocationInput>{
  static bool _locationAccess = false;
  double latitude = 24.12345789;
  double longitude = 67.12345678;
  String? iMageUrl;
  Future<void> checkForLocationPerMission() async{
    if(LocationState._locationAccess){
      Location location = new Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      _setLocationAccess(true);
    }
  }
  void _setLocationAccess(bool locationAccess){
    _locationAccess = locationAccess;
  }
  void getCurrentLocation() async{
    if(_locationAccess){
      checkForLocationPerMission();
    }
    LocationData _locationData;
    Location location = new Location();
    _locationData = await location.getLocation();
    print("location");
    print(_locationData.latitude);
    print(_locationData.longitude);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("latitude: ${_locationData.latitude}\nlongitude: ${_locationData.longitude}"),));
    latitude = _locationData.latitude!;
    longitude = _locationData.longitude!;
    setState(() {
      iMageUrl = LocationHelper.generateLocationPreview(latitude: latitude, longitude: longitude);
      widget._setLocation(LatLng(latitude, longitude));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(width: 1)
          ),
          child: iMageUrl == null ? Center(child: Text("No iMage available")) : Image.network(iMageUrl!, fit: BoxFit.cover, width: double.infinity,),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(onPressed: (){
              getCurrentLocation();
            }, icon: Icon(Icons.location_on), label: Text("Location")),
            FlatButton.icon(onPressed: (){
              print("current loc");
              print(latitude);
              print(longitude);
              Navigator.of(context).push<LatLng>(MaterialPageRoute(builder: (ctx){
                return MapsScreen(initialLocation: PlaceLocation(longitude: longitude, latitude: latitude), isSelecting: true);
              })).then((position){
                print("get location back");
                print(position!.latitude);
                print(position.longitude);
                widget._setLocation(position);
              });
            }, icon: Icon(Icons.map), label: Text("Map"))
          ],
        )
      ],
    );
  }
}