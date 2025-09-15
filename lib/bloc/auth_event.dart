import 'package:boroadwy_2025_session1/models/user.dart';

abstract class AuthEvent {}

class PasswordIconPressedEvent extends AuthEvent {
  bool obscureText;
  PasswordIconPressedEvent(this.obscureText);
}

class SignInEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {}

class SignupEvent extends AuthEvent {
  User user;
  SignupEvent(this.user);
}
