import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/user_details.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../../../engine/notifications/notification_service.dart';
import '../../../../../engine/repository/user_details_repository.dart';

part 'login_state.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.service}) : super(LoginState.loading()) {
    emit(LoginState.empty());
  }

  AuthenticationService service;
  NotificationService _notificationService = GetIt.I();
  UserDetailsRepository detailsRepository = GetIt.I();

  Future<void> signInUser(String email, String password) async {
    emit(LoginState.loading());

    String statusSignUp = await service.signIn(email.trim(), password.trim());

    if(statusSignUp != "Signed in") {
      emit(LoginState.failed(statusSignUp));
    } else {
      UserDetails? details = await detailsRepository.getUserDetails();
      await _notificationService.initialiseNotificationService(details!.notificationsActive);
      emit(LoginState.success());
    }
    return;
  }
}