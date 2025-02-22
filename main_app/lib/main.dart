import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:taxi_grad/core/services/service_locator.dart';
import 'package:taxi_grad/core/utils/app_colors.dart';
import 'package:taxi_grad/core/utils/app_texts.dart';
import 'package:taxi_grad/core/utils/globs.dart';
import 'package:taxi_grad/core/utils/service_call.dart';
import 'package:taxi_grad/core/utils/socket_manager.dart';
import 'package:taxi_grad/features/login/manager/cubit/login_cubit.dart';
import 'package:taxi_grad/features/login/presentation/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocator();

  await Firebase.initializeApp();
  if (Globs.udValueBool(AppTexts.userLogin)) {
    ServiceCall.userObj = Globs.udValue(AppTexts.userPayload) as Map? ?? {};
    ServiceCall.userType = ServiceCall.userObj["user_type"] as int? ?? 1;
  }
  SocketManager.shared.initSocket();

  runApp(const MyApp());
  configLoading();
  ServiceCall.getStaticDateApi();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 5.0
    ..progressColor = TColor.primaryText
    ..backgroundColor = TColor.primary
    ..indicatorColor = Colors.white
    ..textColor = TColor.primaryText
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => LoginCubit())],
      child: MaterialApp(
        title: 'Taxi Driver',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: "NunitoSans",
          scaffoldBackgroundColor: TColor.bg,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: TColor.primary),
          useMaterial3: false,
        ),
        home: const SplashView(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
