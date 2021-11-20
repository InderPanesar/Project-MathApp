import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.service}) : super(RegisterState.loading()) {
    emit(RegisterState.empty());
  }

  AuthenticationService service;

  Future<void> signUpUser(String email, String password) async {
    emit(RegisterState.loading());

    String statusSignUp = await service.signUp(email.trim(), password.trim());

    if(statusSignUp != "Signed up") {
      print(statusSignUp);
      emit(RegisterState.failed());
    } else {
      print("SIGNED UP TO APPLICATION");
      emit(RegisterState.success());
    }
    return;
  }
}