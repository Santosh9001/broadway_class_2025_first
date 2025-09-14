import 'package:flutter/material.dart';

showSnackbarComponent(
  BuildContext context, {
  required String message,
  String state = "neutral",
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: _checkAndReturnSnackbarState(state),
      content: Text(
        message,
        style: TextStyle(
          color: state == 'neutral' ? Colors.black : Colors.white,
        ),
      ),
    ),
  );
}

_checkAndReturnSnackbarState(String state) {
  switch (state) {
    case 'neutral':
      return Colors.grey;
    case 'success':
      return Colors.green[300];
    case 'failure':
      return Colors.red[400];
    default:
      return Colors.grey;
  }
}
