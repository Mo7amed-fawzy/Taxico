import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taxi_grad/core/utils/app_texts.dart';
import 'package:taxi_grad/core/utils/globs.dart';
import 'package:taxi_grad/core/utils/kkey.dart';
import 'package:taxi_grad/core/utils/msg.dart';
import 'package:taxi_grad/core/utils/service_call.dart';
import 'package:taxi_grad/core/utils/svkey.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  void submitLogin(String mobileCode, String mobile, String userType) {
    try {
      emit(LoginHUDState());
      ServiceCall.post(
        {
          "user_type": userType,
          "mobile_code": mobileCode,
          "mobile": mobile,
          "os_type": Platform.isIOS
              ? "i"
              : Platform.isAndroid
                  ? "a"
                  : "w",
          "push_token": "",
          "socket_id": "",
        },
        SVKey.svLogin,
        withSuccess: (responseObj) async {
          if ((responseObj[KKey.status] as String? ?? "") == "1") {
            ServiceCall.userObj = responseObj[KKey.payload] as Map? ?? {};
            ServiceCall.userType =
                ServiceCall.userObj["user_type"] as int? ?? 1;

            Globs.udSet(ServiceCall.userObj, AppTexts.userPayload);
            Globs.udBoolSet(false, "is_online");
            Globs.udBoolSet(true, AppTexts.userLogin);
            emit(LoginApiResultState());
            emit(LoginInitialState());
          } else {
            emit(
              LoginErrorState(responseObj[KKey.message] ?? MSG.fail),
            );
          }
        },
        failure: (err) async {
          emit(LoginErrorState(err));
        },
      );
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
