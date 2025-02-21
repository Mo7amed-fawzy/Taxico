import 'dart:async';
import 'package:geolocator/geolocator.dart';

class AppVars {
  // make the class singelton
  static final AppVars _instance =
      AppVars._internal(); //private constructor (one object)

  factory AppVars() {
    return _instance;
  }

  AppVars._internal();

  // vars
  bool positionSteamStarted = true;
  StreamSubscription<Position>? positionStreamSub;
  Position? lastLocation;
  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  bool isSaveFileLocation = false;
  int bookingId = 0;
}
