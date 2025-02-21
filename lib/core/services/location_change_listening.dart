import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart'
    show LocationAccuracy, LocationSettings;

import 'package:taxi_grad/core/extentions/date_time_extension.dart';
import 'package:taxi_grad/core/services/api_calling_location_update.dart';
import 'package:taxi_grad/core/utils/location_vars.dart';

void locationChangeListening() {
  if (AppVars.positionStreamSub == null) {
    final positionStream = AppVars.geolocatorPlatform.getPositionStream(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 15));

    AppVars.positionStreamSub = positionStream.handleError((error) {
      AppVars.positionStreamSub?.cancel();
      AppVars.positionStreamSub = null;
    }).listen((position) {
      //Api Calling REST Api Calling
      AppVars.lastLocation = position;

      if (AppVars.isSaveFileLocation && AppVars.bookingId != 0) {
        try {
          File("$AppVars.saveFilePath/$AppVars.bookingId.txt").writeAsStringSync(
              ',{"latitude":${position.latitude},"longitude":${position.longitude},"time":"${DateTime.now().stringFormat(format: "yyyy-MM-dd HH:mm:ss")}"}',
              mode: FileMode.append);
          debugPrint("Save Location ---");
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      apiCallingLocationUpdate(position);
    });
  }
}
