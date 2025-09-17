import 'package:boroadwy_2025_session1/bloc/auth_bloc.dart';
import 'package:boroadwy_2025_session1/bloc/auth_event.dart';
import 'package:boroadwy_2025_session1/bloc/auth_state.dart';
import 'package:boroadwy_2025_session1/components/button_component.dart';
import 'package:boroadwy_2025_session1/components/text_inputs.dart';
import 'package:boroadwy_2025_session1/services/local/local_database.dart';
import 'package:boroadwy_2025_session1/signup.dart';
import 'package:boroadwy_2025_session1/utils/app_fonts.dart';
import 'package:boroadwy_2025_session1/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'services/local/local_storage.dart';

class Login extends StatelessWidget {
  Login({super.key});
  // var database = LocalDatabase();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordState) {
            Navigator.pushNamed(context, '/forgotPassword');
            context.read<AuthBloc>().database.retrieveUsers();
          } else if (state is SignupState) {
            // Navigator.pushNamed(
            //   context,
            //   '/signup',
            //   arguments: {"id": "this is sample id"}, // ModalRoute
            // );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "UI Unicorn",
              style: retrieveRequiredFonts(
                AppFonts.title,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nice to see you again
                  const Text(
                    'Nice to see you again',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextInputs(
                    controller: emailController,
                    hintText: 'Enter your email',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                    ),
                    child: Text(
                      'Password',
                      style: retrieveRequiredFonts(AppFonts.small),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    if (state is PasswordIconPressedState) {
                      obscureText = state.obscureText;
                    }
                    return TextInputs(
                      controller: passwordController,
                      hintText: 'Enter your password',
                      obscureText: obscureText,
                      textInputAction: TextInputAction.done,
                      iconData: Icons.remove_red_eye,
                      onIconButtonPressed: () {
                        // i need to know the current state of my text, and update it
                        // _onPasswordIconClicked();
                        context
                            .read<AuthBloc>()
                            .add(PasswordIconPressedEvent(!obscureText));
                      },
                    );
                  }),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Switch(
                            value: false,
                            onChanged: (value) {},
                          ),
                          Text("Remember me"),
                        ],
                      ),
                      TextButton(
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: Colors.blue[400]),
                        ),
                        onPressed: () {
                          context.read<AuthBloc>().add(ForgotPasswordEvent());
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ButtonComponent(
                    buttonText: "Sign in",
                    onButtonPressed: () {
                      context.read<AuthBloc>().database.insertProducts();
                      context.read<AuthBloc>().localStorage.setBool(
                            StringUtils.isUserLoggedInKey,
                            true,
                          );
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16,
                    ),
                    child: Divider(
                      color: Colors.grey[200],
                    ),
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "  "),
                            TextSpan(
                              text: 'Sign up now',
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
          ),
        ));
  }

  // void _onPasswordIconClicked() {
  //   if (obscureText) {
  //     obscureText = false;
  //   } else {
  //     obscureText = true;
  //   }
  // }
}
