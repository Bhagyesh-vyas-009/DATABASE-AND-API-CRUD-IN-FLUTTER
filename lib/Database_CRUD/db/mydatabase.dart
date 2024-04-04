import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyDatabase{
  static const TBL_USER = 'TblUser';
  static const USER_ID = 'UserId';
  static const USER_NAME = 'UserName';

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    Database database = await openDatabase(
      '${databasePath}/newdatabase.db',
      version: 1,
      onUpgrade: (db, oldVersion, newVersion) {},
      onCreate: (db, version) {
        db.execute('CREATE TABLE TblUser(UserId INTEGER PRIMARY KEY AUTOINCREMENT,UserName TEXT)');
      },
    );
    return database;
  }

  Future<List<Map<String,dynamic>>> getUserListFromTblUser()
  async {
    return (await initDatabase()).rawQuery('SELECT * FROM $TBL_USER');
  }

  String apiUrl="https://65c33702f7e6ea59682c264f.mockapi.io/Faculty/";
  Future<dynamic> getAllFacultiesFromAPI() async {
    http.Response response=await http.get(Uri.parse(apiUrl));
    dynamic facultyList=jsonDecode(response.body);
    return facultyList;
  }

  Future<int> insertUserInTblUser(String username) async {
    Database db=await initDatabase();
    Map<String,dynamic> map={};
    map['UserName']=username;

      return db.insert(TBL_USER,map);
  }

  Future<int> deleteIUserFromTblUser(id)
  async {
    Database db=await initDatabase();
    return db.delete(TBL_USER,where: '$USER_ID=?',whereArgs: [id]);
  }

  Future<int> updateUserInTblUser(String username,id) async {
    Database db=await initDatabase();
    Map<String,dynamic> map={};
    map['UserName']=username;
    return db.update(TBL_USER, map,where: '$USER_ID=?',whereArgs: [id]);
  }
}