import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class Databasehelper {
  static final _databasename = "person.db";
  static final _databasesversion = 1;
  static final table = "my_table";
  static final columnId = "id";
  static final columnName = "name";
  static final columnAge = "age";
  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentdirecoty = await getApplicationDocumentsDirectory();
    String path = join(documentdirecoty.path, _databasename);
    return await openDatabase(path,
        version: _databasesversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $table($columnId INTEGER PRIMARY KEY,$columnName TEXT NOT NULL,$columnAge INTEGER NOT NULL)''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  Future<int> deleteo(int id) async {
    Database? db = await instance.database;
    var res = await db!.delete(table, where: "id==?", whereArgs: [id]);
    return res;
  }
}
