import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  // singleton class instance 
  static final LocalStorage _instance = LocalStorage._internal();
  SharedPreferences? sharedPreferences;

  // factory constructor 
  factory LocalStorage() {
    return _instance;
  }
  
  // internal method of LocalStorage
  LocalStorage._internal();

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  bool getBool(String key) {
    return sharedPreferences?.getBool(key) ?? false;
  }

  String getString(String key) {
    return sharedPreferences?.getString(key) ?? "";
  }

  void setBool(String key, bool value) {
    sharedPreferences?.setBool(key, value);
  }

  void setString(String key, String value) {
    sharedPreferences?.setString(key, value);
  }
}
