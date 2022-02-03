import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_page_state.dart';


class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit({required this.repo, required this.secondaryRepo}) : super(HomePageState.loading()) {
    getAccountDetails();
  }

  UserDetailsRepository repo;
  QuestionRepository secondaryRepo;


  Future<void> getAccountDetails() async {
    emit(HomePageState.loading());
    UserDetails? data;
    try {
      data = await repo.getUserDetails();
    } catch(e) {
      print(e.toString());
      emit(HomePageState.failed());
      return;
    }

    if(data == null){
      print("ERROR");
      emit(HomePageState.failed());
    } else {
      emit(HomePageState.success(data));
    }
    return;
  }

  Future<List<Question>?> getIntroQuestions() async {
    List<Question>? data;
    try {
      data = await secondaryRepo.getQuestions("LzLJPpz8dkwFKYfDJNH7");
    } catch(e) {
      return null;
    }
    return data;
  }


}