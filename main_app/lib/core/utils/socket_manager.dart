import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
// import 'package:taxi_driver/common/globs.dart';
// import 'package:taxi_driver/common/service_call.dart';
import 'package:taxi_grad/core/functions/print_statement.dart';
import 'package:taxi_grad/core/utils/app_texts.dart';
import 'package:taxi_grad/core/utils/globs.dart' show Globs;
import 'package:taxi_grad/core/utils/service_call.dart';
import 'package:taxi_grad/core/utils/svkey.dart';

class SocketManager {
  static final SocketManager sigleton = SocketManager._internal();
  SocketManager._internal();
  socket_io.Socket? socket;
  static SocketManager get shared => sigleton;

  void initSocket() {
    socket = socket_io.io(SVKey.mainUrl, {
      "transports": ['websocket'],
      "autoConnect": true
    });

    socket?.on("connect", (data) {
      if (kDebugMode) {
        print("Socket Connect Done");
      }

      //Emit Method

      if (Globs.udValueBool(AppTexts.userLogin)) {
        updateSocketIdApi();
      }
    });

    socket?.on("connect_error", (data) {
      if (kDebugMode) {
        print("Socket Connect Error");
        print(data);
      }
    });

    socket?.on("error", (data) {
      if (kDebugMode) {
        print("Socket Error");
        print(data);
      }
    });

    socket?.on("disconnect", (data) {
      if (kDebugMode) {
        print("Socket disconnect");
        print(data);
      }
    });

    // Out Socket Emit Listener

    socket?.on("UpdateSocket", (data) {
      printHere(" UpdateSocket : ---------------- ");
      printHere(data);
    });
  }

  Future updateSocketIdApi() async {
    try {
      socket?.emit(
          "UpdateSocket",
          jsonEncode(
              {'access_token': ServiceCall.userObj["auth_token"].toString()}));
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
