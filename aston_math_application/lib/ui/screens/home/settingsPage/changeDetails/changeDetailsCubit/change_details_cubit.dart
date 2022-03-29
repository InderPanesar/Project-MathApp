import 'package:aston_math_application/engine/model/UserDetails/user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import '../../../../../../engine/repository/user_details_repository.dart';

part 'change_details_state.dart';


class UserDetailsCubit extends Cubit<UserDetailsState> {
  UserDetailsCubit() : super(UserDetailsState.loading()) {
    emit(UserDetailsState.empty());
  }

  UserDetailsRepository detailsRepository = GetIt.I();

  Future<void> signInUser(String name, String age) async {
    emit(UserDetailsState.loading());
    UserDetails? details = await detailsRepository.getUserDetails();
    if(details != null) {
      details.name = name;
      details.age = age;
      try {
        await detailsRepository.addUserDetails(details);
      } catch (e) {
        emit(UserDetailsState.failed(e.toString()));
        return;
      }
      emit(UserDetailsState.success());
    }
    else {
      emit(UserDetailsState.failed("Details not gained"));
    }

    return;
  }
}