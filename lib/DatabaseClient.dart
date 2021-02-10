import 'dart:io';
import 'package:contactapp/ContactModel.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  static Database _database;
  DatabaseClient._();
  static final DatabaseClient db = DatabaseClient._();

  Future<Database> get database async {
    if (_database != null)
      return _database;
    // if _database is null we instantiate it
    _database = await initDB();// create database
    return _database;
  }

   insertContactData(ContactModel contactModel) async{
    final db = await database;
    var res = await db.rawInsert(
        "INSERT Into contactList (name,email,phone)"
            " VALUES (${contactModel.name},${contactModel.email},${contactModel.phone})");
   // return res;

  /*  var res2 = await db.insert("contactList", contactModel.toMap());
    return res2;*/
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "contact.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE contactList ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "email TEXT,"
          "phone TEXT"
          ")");
    });



  }
}