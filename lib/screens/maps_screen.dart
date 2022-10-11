import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/model/place.dart';

class MapsScreen extends StatefulWidget{
  final PlaceLocation initialLocation;
  final bool isSelecting;
  MapsScreen({required this.initialLocation, required this.isSelecting});
  @override
  State<MapsScreen> createState() {
    return MapsState();
  }
}
class MapsState extends State<MapsScreen>{
  LatLng? _position;
  Set<Marker> _Markers = {};
  void selectPosition(LatLng position){
    setState(() {
      _position = position;
      _Markers = {Marker(
          markerId: MarkerId("Marker 1"),
          position: _position!
      )
      };
      print("set state location");
      print(position.latitude);
      print(position.longitude);
    });
  }
  @override
  void initState() {
    if(!widget.isSelecting){
      _position = LatLng(widget.initialLocation.latitude, widget.initialLocation.longitude);
      _Markers = {
        Marker(markerId: MarkerId("Marker 1"), position: _position!
        )
      };
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Maps"),
        actions: <Widget>[
          if(widget.isSelecting) IconButton(onPressed: _position == null ? null : (){
            Navigator.of(context).pop(_position);
          }, icon: Icon(Icons.check))
        ],
      ),
      body: GoogleMap(initialCameraPosition: CameraPosition(
          target:
          LatLng(widget.initialLocation.getLatitude, widget.initialLocation.getLongitude),
      zoom: 13
      ),
       mapType: MapType.normal,
        myLocationEnabled: true,
        onTap: widget.isSelecting == false ? null : selectPosition,
        markers: _Markers,
      ),
    );
  }
}