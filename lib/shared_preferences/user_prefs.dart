import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
   static String? _key="basit";
  static Future<String?> getUserData() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_key!);
  }

  static Future setUserData(String userId) async{
    final pref = await SharedPreferences.getInstance();
    pref.setString(_key!,userId);
  }





}