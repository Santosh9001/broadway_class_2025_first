import 'package:boroadwy_2025_session1/animated_container.dart';
import 'package:boroadwy_2025_session1/bloc/auth_bloc.dart';
import 'package:boroadwy_2025_session1/bloc/dashboard_bloc.dart';
import 'package:boroadwy_2025_session1/box_animation.dart';
import 'package:boroadwy_2025_session1/forgot_password.dart';
import 'package:boroadwy_2025_session1/hero_animation_one.dart';
import 'package:boroadwy_2025_session1/services/local/local_database.dart';
import 'package:boroadwy_2025_session1/services/local/local_storage.dart';
import 'package:boroadwy_2025_session1/services/notification_service.dart';
import 'package:boroadwy_2025_session1/signup.dart';
import 'package:boroadwy_2025_session1/utils/string_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_master/splash_master.dart';

import 'confirm_OTP.dart';
import 'dashboard.dart';
import 'login.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('message handling background');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SplashMaster.initialize();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyAjvootXLQ_zJa52FGdYzHuU4nsc7hHMdw",
        appId: "1:853909884932:ios:097ea6a7a699b50825e551",
        messagingSenderId: "853909884932",
        projectId: "broadway-infosys"),
  );
  // load crashalytics here
  await LocalStorage().init();
  await LocalDatabase().init();
  SplashMaster.resume();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final localStorage = LocalStorage();
  // final db = LocalDatabase();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => NotificationService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(),
          ),
          BlocProvider(
            create: (_) => DashboardBloc(),
          ),
        ],
        child: MaterialApp(
          routes: {
            "/login": (context) => Login(),
            "/signup": (context) => Signup(),
            "/forgotPassword": (context) => ForgotPassword(),
            "/confirmOTP": (context) => ConfirmOTP(),
            "/dashboard": (context) => Dashboard(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Broadway',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
            useMaterial3: true,
          ),
          // TODO Students, check if the user is signed in
          home: localStorage.getBool(StringUtils.isUserLoggedInKey)
              ? BoxAnimationEg()
              : Login(),
        ),
      ),
    );
  }
}
