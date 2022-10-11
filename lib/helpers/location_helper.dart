import 'dart:convert';

import 'package:http/http.dart' as http;
const GOOGLE_API_KEY = "AIzaSyD64A3G685GSaaH_XdE83LGIsSvIjSnuSc";

class LocationHelper{
  static String generateLocationPreview({required double latitude, required double longitude}){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C40.718217,-73.998284&key=$GOOGLE_API_KEY";
  }
  static Future<Map<String, dynamic>> getPlacesAddress(double lat, double lng) async{
    print("getPlaces");
    String url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY";
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> convertedResponse = json.decode(response.body);
    print(convertedResponse.toString());
    return convertedResponse;
  }
}