import 'package:contactapp/ContactModel.dart';
import 'package:contactapp/DatabaseClient.dart';
import 'package:contactapp/UpdateContact.dart';
import 'package:contactapp/location_screen.dart';
import 'package:flutter/material.dart';

import 'ImagePicker.dart';
import 'MapViewScreen.dart';
import 'addContact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
          primarySwatch: Colors.red,
           visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MapViewScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  DatabaseClient databaseClient;
  List<ContactModel> contactList=  List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseClient= DatabaseClient.db;

    databaseClient.readAllContact().then((value) {
      contactList = value;
      setState(() {

      });
    });

  }
  @override
  Widget build(BuildContext context) {

     return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
      ),
      body: Container(
        child: contactList.length>0?
        ListView.builder(
          itemCount: contactList.length,
          itemBuilder: (context, index) => InkWell(
            onLongPress: (){
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Alert"),
                  content: Text("Do you want to delete"),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: ()  async {
                        var id=await databaseClient.
                        deleteContact(contactList[index].phone);
                        contactList.removeAt(index);
                        setState(() {

                        });
                        Navigator.of(ctx).pop();
                      },
                      child: Text("yes"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("cancel"),
                    ),
                  ],
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contactList[index].name),
                        Text(contactList[index].phone),

                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                            UpdateContact(contactList[index]))).then((value) {
                          databaseClient.readAllContact().then((value) {
                            contactList = value;
                            setState(() {

                            });
                          });
                        });

                      },
                      icon: Icon(Icons.edit),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
            :Text("No contact found"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                AddContact()),
          ).then((value) {
            databaseClient.readAllContact().then((value) {
              contactList = value;
              setState(() {

              });
            });
          });
        },
        tooltip: 'Create new contact',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
