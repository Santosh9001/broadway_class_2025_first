import 'package:boroadwy_2025_session1/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/products.dart';

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
    String productsTable = '''
        create table if not exists products(id int primary_key auto_increment, name varchar(30),
        category varchar(30), price decimal(4,2));
    ''';

    await db.execute(userTable);
    await db.execute(productsTable);
  }

  Future<int> insertUser(String name, String email) async {
    var value = {'name': name, 'email': email};
    return await _database.insert('user', value);
  }

  Future<void> insertProducts() async {
    for (Map<String, dynamic> values in getProducts()) {
      await _database.insert('products', values);
    }
  }

  Future<List<Products>> retrieveProductsByCategory(String name) async {
    var datas = await _database
        .query('products', where: 'category=?', whereArgs: [name]);
    return datas.map((element) => Products.fromJson(element)).toList();
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

  dynamic getProducts() {
    // List<Map<String,dynamic>> productList 
    var products = [
      {'name': 'Basmati', 'price': 20.22, 'category': 'Rice'},
      {'name': 'Moong', 'price': 20.22, 'category': 'Dal'},
      {'name': 'Chips', 'price': 20.22, 'category': 'Snacks'},
      {'name': 'Chana', 'price': 20.22, 'category': 'Dal'}
    ];
    return products;
  }
}
