import 'package:flutter/material.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_places.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:places_app/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value: GreatPlaces(),
    child: MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: PlacesListScreen(),
      routes: {
        AddPlace.routeNaMe : (ctx){
          return AddPlace();
        },
        PlaceDetails.ROUTENAME : (ctx){
          return PlaceDetails();
        }
      },
    ),
    );
  }
}

