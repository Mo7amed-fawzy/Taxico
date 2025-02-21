import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppVars {
  // make the class singelton
  static final AppVars _instance =
      AppVars._internal(); //specific private constructor (one object)

  factory AppVars() {
    //factory same object not create new one
    return _instance;
  }

  AppVars._internal(); //Private Constructor ignore any code out of class to use it

  // vars
  bool positionSteamStarted = true;
  StreamSubscription<Position>? positionStreamSub;
  Position? lastLocation;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  bool isSaveFileLocation = false;
  int bookingId = 0;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
}
