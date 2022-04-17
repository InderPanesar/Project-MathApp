import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/ui/screens/home/homePage/home_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_result_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../../../engine/model/user_details/user_details.dart';

//Question Service used to navigate the pages.
class QuestionService {

  QuestionService({required this.repo});

  UserDetailsRepository repo;

  String _id = "";
  List<Question> _questions = [];
  List<String> _answers = [];
  bool isIntroQuiz = false;
  UserDetails? _details;

  //Starting a quiz with an already retrieved question and appropriate ID (Questions Page)
  void start(BuildContext context, List<Question> questions, String id) {
    if(questions.length == 0) throw Exception;

    _questions = questions;
    _answers = [];
    isIntroQuiz = false;
    _details = null;

    _id = id;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[0], index: 0,)),
    );
  }

  //Starting a one-time personalisation quiz (daily tasks).
  void startPersonalisationQuiz(BuildContext context, List<Question> questions, String id, UserDetails details) {
    if(questions.length == 0) throw Exception;

    _questions = questions;
    _answers = [];
    isIntroQuiz = false;
    _details = details;
    _id = id;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[0], index: 0,)),
    );
  }

  //Start Intro Quiz to get personalisation (One-Time Home-Page)
  void startIntroQuiz(BuildContext context, List<Question> questions) {
    if(questions.length == 0) throw Exception;

    _questions = questions;
    _answers = [];
    _id ="initialisation_quiz";
    isIntroQuiz = true;
    _details = null;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[0], index: 0,)),
    );
  }

  //Move to the next page
  void nextPage(BuildContext context, String answer, int index) async {
    if (_answers.length <= index) {
      _answers.add(answer);
    }
    else {
      _answers[index] = answer;
    }

    if(isLastPage(index)) {
      Map<Question, bool> _map = Map();
      int score = 0;
      for(int i = 0; i < _questions.length; i++) {
        final answers = _questions[i].answer.split(',');
        if(answers.isNotEmpty) {
          for(String answerString in answers) {
            bool answer = answerString == _answers[i];
            if(answer) score++;
            _map[_questions[i]] = answer;
          }
        }
        else {
          bool answer = _questions[i].answer == _answers[i];
          if(answer) score++;
          _map[_questions[i]] = answer;
        }
      }
      UserDetails? details = await repo.getUserDetails();
      if(_details != null) {
        details = _details;
      }


      if(isIntroQuiz) {
        if(details != null) {
          List<String> categories = ["Bodmas", "Changing The Subject", "Expanding Brackets", "Fractions", "Indices", "Percentage", "Quadratic Equations", "Ratio", "Rounding"];
          int index = 0;
          for(Question question in _map.keys) {
            int categoryIndex = index ~/ 2;
            int? userHistoryScore = details.scores[categories[categoryIndex]];
            if (userHistoryScore == null) {
              userHistoryScore = 0;
            }
            if(_map[question]!) {
              userHistoryScore += score;
            }
            details.scores[categories[categoryIndex]] = userHistoryScore;
            index++;
          }
          details.doneHomeQuiz = true;
          await repo.addUserDetails(details);
        }
      }

      else {
        if(details != null) {
          int? userHistoryScore = details.scores[_id];
          if (userHistoryScore == null) {
            userHistoryScore = 0;
          }
          userHistoryScore += score;
          details.scores[_id] = userHistoryScore;

          await repo.addUserDetails(details);
        }
  }


      //Go To Results
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => QuestionResultPage(map: _map, questions:_questions, answers:_answers), fullscreenDialog: true),
          ModalRoute.withName('/')
      ).whenComplete((){
        HomePageCubit cubit = GetIt.instance();
        cubit.getAccountDetails();
      });
    }
    else {
      index++;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage(question: _questions[index], index: index,)),
      );
    }

  }

  //Returns if question is last page
  bool isLastPage(int index) {
    return (index+1) == _questions.length;
  }

  //Get the amount of questions left in the quiz
  double percentage(int index) {
    return (index)/_questions.length;
  }
}