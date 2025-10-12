import 'package:flutter/material.dart';

class FormValidationExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidationExample> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // email field
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is empty';
                  } else if (!value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              // password
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  } else if (value.length < 8) {
                    return 'Please enter password of length atleast 8';
                  }
                  return null;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
