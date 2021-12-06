import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'questions_tab_page_state.dart';


class QuestionTabPageCubit extends Cubit<QuestionTabPageState> {
  QuestionTabPageCubit({required this.repo}) : super(QuestionTabPageState.loading()) {
    getQuestions();
  }

  QuestionMapRepository repo;

  Future<void> getQuestions() async {
    emit(QuestionTabPageState.loading());
    Map<String, dynamic>? data = await repo.getUserDetails();
    if(data == null){
      emit(QuestionTabPageState.failed());
    } else if (data.isEmpty) {
      emit(QuestionTabPageState.empty());
    } else {
      emit(QuestionTabPageState.success(data));
    }
    return;
  }
}