import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ImagePickerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
   return _ImagePickerScreen();
  }

}

class _ImagePickerScreen extends State<ImagePickerScreen>{
  var fileName="";
  var fileSize="";
  final picker = ImagePicker();
  File imageFile;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Image picker"),),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey,
              child: imageFile==null?
              Center(
                child: IconButton(
                  onPressed: (){
                        getImage(ImageSource.gallery);
                  },
                  icon: Icon(Icons.add,size: 50,),
                ),
              ):Image.file(imageFile)
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                 Text("File name:-  ",style: TextStyle(fontSize: 20),),
                 Text(fileName,style: TextStyle(fontSize: 20),)
              ],
            ),
            SizedBox(height: 15,),

            Row(
              children: [
                Text("File size:-  ",style: TextStyle(fontSize: 20),),
                Text(fileSize,style: TextStyle(fontSize: 20),)
              ],
            )
          ],
        ),
      ),
    );
  }


  Future getImage(imageSource) async {
    final pickedFile = await picker.getImage(source: imageSource );

    setState(() async {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        fileName=imageFile.path;
      } else {
        print('No image selected.');
      }
    });

  }

}