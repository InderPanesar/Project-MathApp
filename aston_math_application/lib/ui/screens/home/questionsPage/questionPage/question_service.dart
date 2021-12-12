import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_result_page.dart';
import 'package:flutter/material.dart';

import '../questions_tab_page.dart';

class QuestionService {

  List<Question> _questions = [];
  List<String> _answers = [];

  void start(BuildContext context, List<Question> questions) {
    if(questions.length == 0) throw Exception;

    _questions = questions;
    _answers = [];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[0], index: 0,)),
    );
  }

  void nextPage(BuildContext context, String answer, int index) {
    if (_answers.length <= index) {
      _answers.add(answer);
    }
    else {
      _answers[index] = answer;
    }

    if(isLastPage(index)) {
      Map<Question, bool> _map = Map();
      for(int i = 0; i < _questions.length; i++) {
         bool answer = _questions[i].answer == _answers[i];
         print("QUESTION " + i.toString());
         print(_questions[i].answer);
         print(_answers[i]);
         print(answer);


         _map[_questions[i]] = answer;
      }
      //Go To Results
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => QuestionResultPage(map: _map), fullscreenDialog: true),
          ModalRoute.withName('/')
      );
    }
    else {
      index++;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[index], index: index,)),
      );
    }

  }

  bool isLastPage(int index) {
    return (index+1) == _questions.length;
  }

  double percentage(int index) {
    return (index)/_questions.length;
  }
}