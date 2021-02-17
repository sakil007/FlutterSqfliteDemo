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
  
  
  Future<int> deleteContact(String phone) async{
    final db = await database;
    return await db.delete("contactList", where: 'phone = ?', whereArgs: [phone]);
  }

  Future<int> updateContact(ContactModel contactModel) async {
    final db = await database;

    return await db.update('contactList', contactModel.toMap(),
        where: 'phone = ?', whereArgs: [contactModel.phone]);
  }

  Future<int> insertContactData(ContactModel contactModel) async{
    final db = await database;

    var res =await  db.query("contactList",
        where: "phone = ?", whereArgs: [contactModel.phone]);

    var id= res.isNotEmpty ?
        -1
        :  await db.insert("contactList", contactModel.toMap());

    return id;
  }

  Future<List<ContactModel>> readAllContact() async{
    final db = await database;
    var res = await db.query("contactList");
    List<ContactModel> list =
    res.isNotEmpty ?
    res.map((c) => ContactModel.fromMap(c)).toList()
        : [];
    return list;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "contact.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      print("========================");
      await db.execute("CREATE TABLE contactList ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "email VARCHAR (20),"
          "phone TEXT"
          ")");
    });



  }
}