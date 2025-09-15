import 'package:boroadwy_2025_session1/bloc/auth_bloc.dart';
import 'package:boroadwy_2025_session1/forgot_password.dart';
import 'package:boroadwy_2025_session1/services/local/local_database.dart';
import 'package:boroadwy_2025_session1/services/local/local_storage.dart';
import 'package:boroadwy_2025_session1/signup.dart';
import 'package:boroadwy_2025_session1/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirm_OTP.dart';
import 'dashboard.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage().init();
  await LocalDatabase().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final localStorage = LocalStorage();
  // final db = LocalDatabase();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(),
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
        home: localStorage.getBool(StringUtils.isUserLoggedInKey) ? Dashboard() : Login(),
      ),
    );
  }
}
