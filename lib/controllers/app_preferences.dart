import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  void save(bool sound) {
    SharedPreferences.getInstance().then((pref) {
      pref.setBool('sound', sound).catchError((e) {
        debugPrint('Failed to save preference');
      });
    });
  }

  Future<bool> soundEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('sound') ?? true;
  }
}
