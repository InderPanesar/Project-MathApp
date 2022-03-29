import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/user_details.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../engine/notifications/notification_service.dart';
import '../../../../../engine/repository/user_details_repository.dart';

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