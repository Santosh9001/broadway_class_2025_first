import 'package:boroadwy_2025_session1/bloc/auth_state.dart';
import 'package:boroadwy_2025_session1/services/local/local_database.dart';
import 'package:boroadwy_2025_session1/services/local/local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final localStorage = LocalStorage();
  final database = LocalDatabase();
  AuthBloc() : super(AuthInitial()) {
    on<PasswordIconPressedEvent>((event, emit) {
      emit(PasswordIconPressedState(event.obscureText));
    });

    on<SignInEvent>((event, emit) {
      emit(SigninState());
    });

    on<SignupEvent>((event, emit) async {
      var check =
          await database.insertUser(event.user.name!, event.user.email!);
      debugPrint("$check");
      if (check == -1) {
        emit(AuthErrorState());
        return;
      }
      emit(SignupState());
    });

    on<ForgotPasswordEvent>((event, emit) {
      emit(ForgotPasswordState());
    });
  }
}
