import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth.dart';

class sharedPreferences {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  setUserData(ModelLogin value) async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', modelLoginToJson(value));
  }
  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.getString('user')!=null)
      return modelLoginFromJson(prefs.getString('user'));
    else
      return null;
  }

}