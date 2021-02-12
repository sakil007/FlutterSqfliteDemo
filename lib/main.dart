import 'package:contactapp/ContactModel.dart';
import 'package:contactapp/DatabaseClient.dart';
import 'package:flutter/material.dart';

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
          primarySwatch: Colors.blue,
           visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: [
                  Text(contactList[index].name),
                  Text(contactList[index].phone),
                ],
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


