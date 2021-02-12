import 'package:contactapp/ContactModel.dart';
import 'package:contactapp/DatabaseClient.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddContact extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addContact();
  }

}
class _addContact extends State<AddContact>{


  var _formKey= GlobalKey<FormState>();
  var nameController,phoneController,emailController;
  var databaseClient;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseClient = DatabaseClient.db;
    nameController= TextEditingController();
    phoneController= TextEditingController();
    emailController= TextEditingController();

  }
  void showToast(msg){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(title: Text("Add Contact"),),
      body: Container(
        padding: EdgeInsets.all(10),
           child: Form(
             key: _formKey,
             child: Column(
               children: [
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                 child: TextFormField(
                   controller: nameController,
                   validator: (value){
                     if(value.isEmpty){
                     //  showToast("Please enter your name");
                           return "Please enter your name";
                     }
                     return null;
                   },
                   decoration: InputDecoration(
                     hintText: "Enter your name",

                   ),
                 ),),
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                   child: TextFormField(
                     controller: phoneController,
                     validator: (value){
                       if(value.isEmpty){
                         return "Please enter your phone";
                       } else if(value.length!=10){
                         return "Please enter valid phone";
                       }
                       return null;
                     },
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       hintText: "Enter your phone",
                       prefix: Text("+91"),

                     ),
                   ),),
                 Padding(padding: EdgeInsets.only(top:10,bottom: 10),

                   child: TextFormField(
                     controller: emailController,
                     validator: (value){
                       if(value.isEmpty){
                         //  showToast("Please enter your name");
                         return "Please enter your email";
                       }
                       return null;
                     },
                     decoration: InputDecoration(
                       hintText: "Enter your email",

                     ),
                   ),),

                 SizedBox(
                   height: 20),
                   RaisedButton(
                     onPressed: () async {
                       if(_formKey.currentState.validate()){
                         var databaseID= await databaseClient.insertContactData(
                             new ContactModel(email: emailController.text,
                             name: nameController.text,
                             phone: phoneController.text));

                         showToast("Success"+databaseID.toString());
                       }else{
                         showToast("failed");
                       }

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