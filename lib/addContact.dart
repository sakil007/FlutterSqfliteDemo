import 'package:flutter/material.dart';

class AddContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addContact();
  }

}
class _addContact extends State<AddContact>{

  var _formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Add Contact"),),
      body: Container(
        padding: EdgeInsets.all(10),
           child: Form(
             key: _formKey,
             child: Column(
               children: [
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                 child: TextField(
                   decoration: InputDecoration(
                     hintText: "Enter your name",

                   ),
                 ),),
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                   child: TextField(
                     decoration: InputDecoration(
                       hintText: "Enter your phone",
                       prefix: Text("+91")

                     ),
                   ),),
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                   child: TextField(
                     decoration: InputDecoration(
                       hintText: "Enter your email",

                     ),
                   ),),

                 SizedBox(
                   height: 20),
                   RaisedButton(
                     onPressed: (){

                     },
                     color: Colors.green,
                     child: Text("Save"),

                 ),
               ],
             ),
           ),
      ),
    );
  }

}