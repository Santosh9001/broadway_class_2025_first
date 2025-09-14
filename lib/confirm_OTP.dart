import 'package:boroadwy_2025_session1/components/button_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ConfirmOTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Confirm OTP"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter the OTP sent in your email id "),
              const SizedBox(
                height: 16,
              ),
              OtpTextField(
                numberOfFields: 5,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                }, // end onSubmit
              ),
              const SizedBox(
                height: 16,
              ),
              ButtonComponent(
                buttonText: 'Submit OTP',
                onButtonPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    ModalRoute.withName('/'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
