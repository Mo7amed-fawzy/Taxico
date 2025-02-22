//  TODO: ApiCall

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taxi_grad/core/utils/kkey.dart';
import 'package:taxi_grad/core/utils/service_call.dart' show ServiceCall;
import 'package:taxi_grad/core/utils/socket_manager.dart' show SocketManager;
import 'package:taxi_grad/core/utils/svkey.dart';

void apiCallingLocationUpdate(Position pos) {
  if (ServiceCall.userType != 2) {
    return;
  }

  debugPrint(" Driver Location sending api calling");

  ServiceCall.post({
    "latitude": pos.latitude.toString(),
    "longitude": pos.longitude.toString(),
    "socket_id": SocketManager.shared.socket?.id ?? ""
  }, SVKey.svUpdateLocationDriver, isTokenApi: true,
      withSuccess: (responseObj) async {
    if (responseObj[KKey.status] == "1") {
      debugPrint(" Location send success");
    } else {
      debugPrint(
          " Location send fill : ${responseObj[KKey.message].toString()}");
    }
  }, failure: (error) async {
    debugPrint(" Location send fill : $error");
  });
}
