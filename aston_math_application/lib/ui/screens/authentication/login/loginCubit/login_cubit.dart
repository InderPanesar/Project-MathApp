import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.service}) : super(LoginState.loading()) {
    emit(LoginState.empty());
  }

  AuthenticationService service;

  Future<void> signInUser(String email, String password) async {
    emit(LoginState.loading());

    String statusSignUp = await service.signIn(email.trim(), password.trim());

    if(statusSignUp != "Signed in") {
      emit(LoginState.failed(statusSignUp));
    } else {
      print("SIGNED IN TO APPLICATION");
      emit(LoginState.success());
    }
    return;
  }
}