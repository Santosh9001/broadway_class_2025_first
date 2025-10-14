import 'package:boroadwy_2025_session1/bloc/auth_bloc.dart';
import 'package:boroadwy_2025_session1/bloc/auth_event.dart';
import 'package:boroadwy_2025_session1/bloc/auth_state.dart';
import 'package:boroadwy_2025_session1/components/snackbar_component.dart';
import 'package:boroadwy_2025_session1/components/text_inputs.dart';
import 'package:boroadwy_2025_session1/login.dart';
import 'package:boroadwy_2025_session1/models/user.dart';
import 'package:boroadwy_2025_session1/services/notification_service.dart';
import 'package:boroadwy_2025_session1/utils/app_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/button_component.dart';

class Signup extends StatelessWidget {
  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Sign up",
          style: retrieveRequiredFonts(
            AppFonts.title,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is SignupState) {
          showSnackbarComponent(context, message: 'Success signup user');
        } else if (state is AuthErrorState) {
          showSnackbarComponent(context, message: 'Error signup user');
        }
      }, builder: (context, state) {
        if (state is AuthInitial) {
          final notificationService = context.read<NotificationService>();
          notificationService.initialize();
        }
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome to UI Unicorn',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'Name',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextInputs(
                  controller: nameController,
                  hintText: "Enter your name",
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'Email',
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextInputs(
                  controller: emailController,
                  hintText: "Enter your email",
                ),
                const SizedBox(
                  height: 16,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextInputs(
                  controller: passwordController,
                  hintText: "Enter your password",
                  iconData: Icons.remove_red_eye,
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    'Confirm password',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextInputs(
                  controller: confirmPassword,
                  hintText: "Confirm Password",
                  iconData: Icons.remove_red_eye,
                ),
                const SizedBox(
                  height: 16,
                ),
                ButtonComponent(
                  buttonText: "Sign up",
                  onButtonPressed: () {
                    _checkAndSignupUser(context);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Login(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account ?',
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(text: "  "),
                          TextSpan(
                            text: 'Sign in now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[400],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _checkAndSignupUser(BuildContext context) async {
    String name = nameController.text;
    String email = emailController.text;
    String pass = passwordController.text;
    String cPass = confirmPassword.text;
    if (name.isEmpty || email.isEmpty || pass.isEmpty || cPass.isEmpty) {
      showSnackbarComponent(
        context,
        message: "Please check your required fields",
        state: 'error',
      );
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: 'test@gmail.com',
          password: '123456',
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      return;
    } else if (pass != cPass) {
      // TODO make this a component
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match!!"),
        ),
      );
      return;
    } else {
      // User user = User(
      //   name: name,
      //   email: email,
      //   password: pass,
      //   confirmPassword: cPass,
      // );
      // context.read<AuthBloc>().add(SignupEvent(user));

      // Forward it to service or state-managemet so that it can be passed to db
    }
  }
}
