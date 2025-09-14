import 'package:boroadwy_2025_session1/components/button_component.dart';
import 'package:boroadwy_2025_session1/components/text_inputs.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Forgot Password"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                    "Please enter your email for sending OTP \ncode for your password reset!"),
              ),
              const SizedBox(
                height: 16,
              ),
              TextInputs(
                controller: emailController,
                hintText: "Enter your email",
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonComponent(
                buttonText: "Send OTP Code",
                onButtonPressed: () {
                  if (emailController.text.isNotEmpty) {
                    Navigator.pushNamed(
                      context,
                      '/confirmOTP',
                      arguments: {"email": emailController.text},
                    );
                  } else {
                    /// condition or popup
                    return;
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
