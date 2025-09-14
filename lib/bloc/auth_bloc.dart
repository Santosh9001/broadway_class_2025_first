import 'package:boroadwy_2025_session1/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<PasswordIconPressedEvent>((event, emit) {
      emit(PasswordIconPressedState(event.obscureText));
    });

    on<SignInEvent>((event, emit) {
      emit(SigninState());
    });

    on<SignupEvent>((event, emit) {
      emit(SignupState());
    });

    on<ForgotPasswordEvent>((event, emit) {
      emit(ForgotPasswordState());
    });
  }
}
