import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


part 'forgot_password_state.dart';


class ForgottenPasswordCubit extends Cubit<ForgottenPasswordState> {
  ForgottenPasswordCubit({required this.service}) : super(ForgottenPasswordState.loading()) {
    emit(ForgottenPasswordState.empty());
  }

  AuthenticationService service;

  Future<void> resetPassword(String email) async {
    emit(ForgottenPasswordState.loading());
    String value = await service.resetPassword(email);
    if(value != "Email Sent") {
      emit(ForgottenPasswordState.failed(value));
    } else {
      emit(ForgottenPasswordState.success());
    }
    return;
  }
}