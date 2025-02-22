import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_grad/core/extentions/app_context.dart';
import 'package:taxi_grad/core/utils/app_colors.dart';
import 'package:taxi_grad/core/utils/app_texts.dart';
import 'package:taxi_grad/core/utils/globs.dart';
import 'package:taxi_grad/core/utils/kkey.dart';
import 'package:taxi_grad/core/utils/service_call.dart';
import 'package:taxi_grad/features/home/home_view.dart';
import 'package:taxi_grad/features/login/presentation/change_language_view.dart';
import 'package:taxi_grad/features/login/presentation/profile_image_view.dart';
import 'package:taxi_grad/features/user/user_home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    super.initState();
    load();
  }

  void load() async {
    await Future.delayed(const Duration(seconds: 3));
    loadNextScreen();
  }

  void loadNextScreen() {
    if (Globs.udValueBool(AppTexts.userLogin)) {
      if (ServiceCall.userType == 2) {
        //Driver Login
        if (ServiceCall.userObj[KKey.status] == 1) {
          context.push(const HomeView());
        } else {
          context.push(const ProfileImageView());
        }
      } else {
        //User Login
        context.push(const UserHomeView());
      }
    } else {
      context.push(const ChangeLanguageView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: context.width,
            height: context.height,
            color: TColor.primary,
          ),
          Image.asset(
            "assets/img/app_logo.png",
            width: context.width * 0.25,
          )
        ],
      ),
    );
  }
}
