import 'package:boroadwy_2025_session1/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  // Database ORM
  static final LocalDatabase _localDatabase = LocalDatabase._internal();
  late Database _database;

  factory LocalDatabase() {
    return _localDatabase;
  }

  LocalDatabase._internal();

  Future<void> init() async {
    // file path users/games/fifa/new/abc.db
    final directory = await getApplicationDocumentsDirectory();
    final dbPath = '${directory.path}/broadway.db';

    // opening database
    _database = await openDatabase(
      dbPath,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    String userTable = '''
        create table if not exists user (id int primary_key, name varchar(30), email varchar(30));
      ''';
    String categoryTable = '''

    ''';
    await db.execute(userTable);
    // await db.execute(categoryTable);
  }

  Future<int> insertUser(String name, String email) async {
    var value = {'name': name, 'email': email};
    return await _database.insert('user', value);
  }

  Future<List<User>> retrieveUsers() async {
    // select * from user;
    var datas = await _database.query('user');
    List<User> userList = [];
    // convert List<Map<String,dynamic>> to List<User>
    for (Map<String, dynamic> json in datas) {
      userList.add(User.fromJson(json));
    }

    // Single line loop conversion 
    // datas.map((element) => User.fromJson(element)).toList();

    debugPrint("$userList");
    return userList;
  }
}
