import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class QuestionPageCubit {
  QuestionService service = GetIt.I();
  int index;
  Question question;

  QuestionPageCubit({required this.index, required this.question});



  bool isLastPage() {
    return service.isLastPage(index);
  }

  double getPercentage() {
    return service.percentage(index);
  }

  String buttonText() {
    if(service.isLastPage(index)) {
      return "Finish";
    }
    return "Next";
  }

  String appBarText() {
    return "Question " + (index+1).toString();
  }

  String returnQuestions() {
    return question.preQuestion + "\n" + question.question + question.afterQuestion;
  }

  void goToNextPage(BuildContext context, String input) {
    service.nextPage(context, input, index);
  }



}