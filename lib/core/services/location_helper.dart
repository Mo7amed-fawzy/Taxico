import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart'
    show
        // GeolocatorPlatform,
        // LocationAccuracy,
        LocationPermission,
        // LocationSettings,
        Position,
        ServiceStatus;
import 'package:path_provider/path_provider.dart'
    show getApplicationCacheDirectory, getTemporaryDirectory;
import 'package:taxi_grad/core/extentions/date_time_extension.dart';
import 'package:taxi_grad/core/functions/print_statement.dart';
import 'package:taxi_grad/core/services/location_change_listening.dart';
import 'package:taxi_grad/core/utils/location_vars.dart';

class LocationHelper {
  static final LocationHelper singleton = LocationHelper.internal();
  factory LocationHelper() => singleton;
  LocationHelper.internal();
  static LocationHelper shared() => singleton;

  StreamSubscription<ServiceStatus>? serviceStatusStreamSub;
  String saveFilePath = "";

  void startInit() async {
    var isAccess = await handlePermission();

    if (!isAccess) {
      return;
    }

    saveFilePath = (await getSavePath()).path;

    if (serviceStatusStreamSub == null) {
      final serviceStatusStream =
          AppVars().geolocatorPlatform.getServiceStatusStream();
      serviceStatusStreamSub = serviceStatusStream.handleError((error) {
        serviceStatusStreamSub?.cancel();
        serviceStatusStreamSub = null;
      }).listen((serviceStatus) {
        String serviceStatusValue;

        if (serviceStatus == ServiceStatus.enabled) {
          if (AppVars().positionSteamStarted) {
            //Start Location Listen logic
            locationChangeListening();
          }
          serviceStatusValue = "enabled";
        } else {
          if (AppVars().positionStreamSub != null) {
            AppVars().positionStreamSub?.cancel();
            AppVars().positionStreamSub = null;

            printHere("Position Stream han been canceled");
          }

          serviceStatusValue = "disabled";
        }
        printHere("Location service has been $serviceStatusValue");
      });
    }
  }

  void locationSendPause() {
    if (AppVars().positionStreamSub != null) {
      AppVars().positionStreamSub?.cancel();
      AppVars().positionStreamSub = null;
      AppVars().positionSteamStarted = false;
    }
  }

  void locationSendStart() {
    if (AppVars().positionSteamStarted) {
      return;
    }

    locationChangeListening();
  }

  Future<bool> handlePermission() async {
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable =
        await AppVars().geolocatorPlatform.isLocationServiceEnabled();

    if (!serviceEnable) {
      return false;
    }

    permission = await AppVars().geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await AppVars().geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  void startRideLocationSave(int bId, Position position) {
    AppVars().bookingId = bId;

    try {
      File("$saveFilePath/$AppVars.bookingId.txt").writeAsStringSync(
          '{"latitude":${position.latitude},"longitude":${position.longitude},"time":"${DateTime.now().stringFormat(format: "yyyy-MM-dd HH:mm:ss")}"}',
          mode: FileMode.append);

      debugPrint("Save Location ---");
      AppVars().isSaveFileLocation = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void stopRideLocationSave() {
    AppVars().isSaveFileLocation = false;
    AppVars().bookingId = 0;
  }

  Future<Directory> getSavePath() async {
    if (Platform.isAndroid) {
      return getTemporaryDirectory();
    } else {
      return getApplicationCacheDirectory();
    }
  }

  String getRideSaveLocationJsonString(int bookingId) {
    try {
      return "[${File("$saveFilePath/$bookingId.txt").readAsStringSync()}]";
    } catch (e) {
      debugPrint(e.toString());
      return "[]";
    }
  }
}
