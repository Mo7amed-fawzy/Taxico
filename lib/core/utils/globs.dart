import 'dart:convert';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class Globs {
  static final SharedPreferences prefs = GetIt.I<SharedPreferences>();

  static void showHUD({String status = "loading ...."}) async {
    await Future.delayed(const Duration(milliseconds: 1));
    EasyLoading.show(status: status);
  }

  static void hideHUD() {
    EasyLoading.dismiss();
  }

  static void udSet(dynamic data, String key) {
    var jsonStr = json.encode(data);
    prefs.setString(key, jsonStr);
  }

  static void udStringSet(String data, String key) {
    prefs.setString(key, data);
  }

  static void udBoolSet(bool data, String key) {
    prefs.setBool(key, data);
  }

  static void udIntSet(int data, String key) {
    prefs.setInt(key, data);
  }

  static void udDoubleSet(double data, String key) {
    prefs.setDouble(key, data);
  }

  static dynamic udValue(String key) {
    return json.decode(prefs.get(key) as String? ?? "{}");
  }

  static String udValueString(String key) {
    return prefs.getString(key) ?? "";
  }

  static bool udValueBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  static bool udValueTrueBool(String key) {
    return prefs.getBool(key) ?? true;
  }

  static int udValueInt(String key) {
    return prefs.getInt(key) ?? 0;
  }

  static double udValueDouble(String key) {
    return prefs.getDouble(key) ?? 0.0;
  }

  static void udRemove(String key) {
    prefs.remove(key);
  }

  static Future<String> timeZone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (e) {
      return "";
    }
  }
}
