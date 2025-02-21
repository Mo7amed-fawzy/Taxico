import 'dart:async' show StreamSubscription;

import 'package:geolocator/geolocator.dart' show GeolocatorPlatform, Position;

abstract class AppVars {
  static bool positionSteamStarted = true;
  static StreamSubscription<Position>? positionStreamSub;
  static Position? lastLocation;
  static final GeolocatorPlatform geolocatorPlatform =
      GeolocatorPlatform.instance;

  static bool isSaveFileLocation = false;
  static int bookingId = 0;
}
