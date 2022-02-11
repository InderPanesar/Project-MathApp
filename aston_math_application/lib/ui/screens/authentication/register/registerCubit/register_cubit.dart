import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.service}) : super(RegisterState.loading()) {
    emit(RegisterState.empty());
  }

  AuthenticationService service;
  UserDetailsRepository detailsRepository = GetIt.I();

  Future<void> signUpUser(String email, String password) async {
    emit(RegisterState.loading());

    String statusSignUp = await service.signUp(email.trim(), password.trim());

    if(statusSignUp != "Signed up") {
      emit(RegisterState.failed());
    } else {
      await detailsRepository.addUserDetails(new UserDetails(name: "", age: "", doneHomeQuiz: false, scores: new Map(), lastActive: Timestamp.fromDate(new DateTime(2000)), questions: new Map(), recommendedVideo: []));
      emit(RegisterState.success());
    }
    return;
  }
}