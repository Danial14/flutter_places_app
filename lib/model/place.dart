import 'dart:io';
class PlaceLocation{
  final double latitude;
  final double longitude;
  String? _address;
  PlaceLocation({
    required this.longitude,
    required this.latitude,
});
  double get getLatitude{
    return latitude;
}
double get getLongitude{
    return longitude;
}
void set setLocation(String address){
    this._address = address;
}
String get getAddress{
    return _address!;
}
}
class Place{
  final String id;
  final String title;
  PlaceLocation? location;
  final File image;
  Place({
    required this.id, required this.title, required this.image, required this.location
  });
}