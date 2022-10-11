import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;


class ImageInput extends StatefulWidget{
  final Function selectIMage;
  ImageInput({required this.selectIMage});
  @override
  State<StatefulWidget> createState() {
    return ImageInputState();
  }
}
class ImageInputState extends State<ImageInput>{
  File? _storedIMage;
  Future<void> takePicture() async{
    final iMage = await ImagePicker().pickImage(source: ImageSource.camera, maxWidth: 600);
    if(iMage == null){
      print("iMage is null");
      return;
    }
    setState(() {
      _storedIMage = File(iMage.path);
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileNaMe = path.basename(_storedIMage!.path);
    print("fileNaMe: $fileNaMe");
    print("storeiMagepath: ${_storedIMage!.path}");
    final savedIMage = await _storedIMage!.copy("${appDir.path}/$fileNaMe");
    print("storeiMagepath: ${savedIMage.path}");
    widget.selectIMage(savedIMage);
  }
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
      width: 150,
      height: 100,
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Colors.grey,

          )
      ),
      child: _storedIMage != null ? Image.file(_storedIMage!, fit: BoxFit.cover, width: double.infinity,) : Text("No iMage taken", textAlign: TextAlign.center,),
      alignment: Alignment.center,
    ),
      SizedBox(width: 10,),
      Expanded(
        child: FlatButton.icon(onPressed: takePicture, icon: Icon(Icons.camera), label: Text("Take picture"),
        textColor: Theme.of(context).primaryColor,
        ),
      )
    ],);
  }
}