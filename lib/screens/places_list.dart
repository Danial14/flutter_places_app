import 'package:flutter/material.dart';
import 'package:places_app/helpers/db_helper.dart';
import 'package:places_app/providers/great_places.dart';
import 'package:places_app/screens/add_places.dart';
import 'package:places_app/screens/places_details.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    Provider.of<GreatPlaces>(context, listen: false).fetchData();
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.of(context).pushNamed(AddPlace.routeNaMe);
          }, icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: Text("Sorry soMething went wrong"),
        ),
        builder: (ctx, greatPlaces, ch){
          return greatPlaces.getPlaces.length == 0 ? ch! : ListView.builder(itemBuilder: (ctx, ind){
            return Card(child :
            ListTile(
              onTap: (){
                Navigator.of(context).pushNamed(PlaceDetails.ROUTENAME, arguments: greatPlaces.getPlaces[ind].id);
              },
              leading: CircleAvatar(
                backgroundImage: FileImage(greatPlaces.getPlaces[ind].image),

              ),
              title: Text(greatPlaces.getPlaces[ind].title),
              subtitle: Text(greatPlaces.getPlaces[ind].location!.getAddress),
              trailing: IconButton(icon: Icon(Icons.delete), onPressed: (){
                Provider.of<GreatPlaces>(context, listen: false).delete("user_places", greatPlaces.getPlaces[ind].id, ind);
              },)
            ),
              elevation: 5,
            );
          }, itemCount: greatPlaces.getPlaces.length,);
        },
      ),
    );
  }
}