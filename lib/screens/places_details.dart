import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/maps_screen.dart';
import 'package:provider/provider.dart';

import '../model/place.dart';

class PlaceDetails extends StatelessWidget{
  static const ROUTENAME = "/PlaceDetails";
  @override
  Widget build(BuildContext context) {
    final String placeId = ModalRoute.of(context)!.settings.arguments as String;
    Place place = Provider.of<GreatPlaces>(context, listen: false).getPlaceById(placeId);
    print("place details");
    print(place.location!.latitude);
    print(place.location!.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text("Place details"),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.file(place.image, fit: BoxFit.cover, height: 150,),
          SizedBox(height: 10,),
          Text(place.title,
            style: TextStyle(fontSize: 30,
                fontWeight: FontWeight.bold
            ),),
          SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                return MapsScreen(initialLocation: place.location!, isSelecting: false,);
              }));
            },
            child: Text(
                "View Map",
                style: TextStyle(
                    color: Colors.blue,
                    decorationStyle: TextDecorationStyle.solid
                )
            ),
          )
        ],
      ),),
    );
  }
}