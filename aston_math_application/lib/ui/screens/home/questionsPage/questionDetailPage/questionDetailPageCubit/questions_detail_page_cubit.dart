import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'questions_detail_page_state.dart';


class QuestionDetailPageCubit extends Cubit<QuestionDetailPageState> {
  QuestionDetailPageCubit({required this.repo}) : super(QuestionDetailPageState.loading());

  QuestionRepository repo;

  Future<void> getQuestions(String id) async {
    emit(QuestionDetailPageState.loading());
    List<Question>? data;
    try {
       data = await repo.getQuestions(id);
    } catch(e) {
      print("ERROR");
      emit(QuestionDetailPageState.failed());
      return;
    }

    if(data == null){
      print("ERROR");
      emit(QuestionDetailPageState.failed());
    } else if (data.isEmpty) {
      emit(QuestionDetailPageState.empty());
    } else {
      emit(QuestionDetailPageState.success(data));
    }
    return;
  }


}