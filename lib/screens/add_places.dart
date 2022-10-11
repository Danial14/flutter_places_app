import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/widgets/Location_input.dart';
import 'package:places_app/widgets/image_input.dart';
import 'package:provider/provider.dart';

import '../model/place.dart';

class AddPlace extends StatefulWidget{
  static const String routeNaMe = "/addPlace";
  @override
  State<AddPlace> createState() {
    return AddPlaceState();
  }
}
class AddPlaceState extends State<AddPlace>{
  TextEditingController _textEditingController = TextEditingController();
  File? _iMageFile;
  void selectIMage(File iMage){
    _iMageFile = iMage;
  }
  void savePlace(){
    if(_textEditingController.text.isEmpty || _iMageFile == null){
      return;
    }
    LatLng locData = LocationInput.getUserSelectedLocation();
    Place place = Place(id: DateTime.now().toIso8601String(), title: _textEditingController.text, image: _iMageFile!, location: PlaceLocation(latitude: locData.latitude, longitude: locData.longitude));
    Provider.of<GreatPlaces>(context, listen: false).addPlace(place);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new place"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  SizedBox(height: 10,),
                  ImageInput(selectIMage: selectIMage,),
                  LocationInput()
                ],
              ),
            ),
          ),
          RaisedButton.icon(
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            icon: Icon(Icons.add),
            label: Text("Add place"),
            onPressed: savePlace,
            color: Theme.of(context).primaryColorDark,
          )
        ],
      ),
    );
  }
}