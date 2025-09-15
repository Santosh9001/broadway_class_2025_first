abstract class AuthState {}

class AuthInitial extends AuthState {}

class PasswordIconPressedState extends AuthState {
  bool obscureText;
  PasswordIconPressedState(this.obscureText);
}

class SignupState extends AuthState {}

class ForgotPasswordState extends AuthState {}

class SigninState extends AuthState {}

class AuthErrorState extends AuthState {}
