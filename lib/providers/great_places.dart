import 'dart:io';

import 'package:flutter/material.dart';
import 'package:places_app/model/place.dart';

import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier{
  List<Place> _places = [];
  List<Place> get getPlaces{
    return [..._places];
  }
  void addPlace(Place place) async{
    Map<String, dynamic> response = await LocationHelper.getPlacesAddress(place.location!.latitude, place.location!.longitude);
    print("add place");
    print("response");
    print(response);
    place.location!.setLocation = response["results"][0]["formatted_address"] as String;
    _places.add(place);
    notifyListeners();
    await DbHelper.insert("user_places", {"id" : place.id,
      "title" : place.title,
      "image" : place.image.path,
      "lat" : place.location!.latitude,
      "lng" : place.location!.longitude,
      "address" : place.location!.getAddress
    });
  }
  Future<List<Map<String, Object>>?> fetchData() async {
    _places = [];
    List<Map<String, Object?>> data = await DbHelper.fetchData("user_places");
    print("fetching...");
    print(data);
    if (data != null) {
      data.forEach((element) {
        PlaceLocation placeLocation = PlaceLocation(longitude: element["lat"] as double, latitude: element["lng"] as double);
        placeLocation.setLocation = element["address"] as String;
        Place newPlace = Place(id: element["id"] as String,
            title: element["title"] as String,
            image: File(element["image"] as String),
            location: placeLocation);
        _places.add(newPlace);
        notifyListeners();
      });
    }
  }
  void delete(String table, String id, int ind) async{
    await DbHelper.delete(table, id);
    _places.removeAt(ind);
    notifyListeners();
  }
  Place getPlaceById(String id){
    return _places.firstWhere((place){
      return place.id == id;
    });
  }
}