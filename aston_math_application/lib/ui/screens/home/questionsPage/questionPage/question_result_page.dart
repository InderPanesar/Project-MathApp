import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get_it/get_it.dart';
import 'package:math_keyboard/math_keyboard.dart';

class QuestionResultPage extends StatefulWidget {

  Map<Question, bool> map;
  List<Question> questions;
  List<String> answers;


  QuestionResultPage({required this.map, required this.questions, required this.answers});

  @override _QuestionResultPageState createState() => _QuestionResultPageState(map: this.map, questions: this.questions, answers:this.answers);
}

class _QuestionResultPageState extends State<QuestionResultPage> {

  Map<Question, bool> map;
  List<Question> questions;
  List<String> answers;

  _QuestionResultPageState({required this.map, required this.questions, required this.answers});


  Widget createTable() {
    List<TableRow> rows = [];
    int i = 1;
    int score = 0;
    rows.add(TableRow(children: [
      Container(
        color: Colors.grey,
        child: Text("Question", textAlign: TextAlign.center),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
      Container(
        color: Colors.grey,
        child: Text("Correct", textAlign: TextAlign.center),
        padding: EdgeInsets.symmetric(vertical: 10),
      ),
    ]));
    for (bool rightOrWrong in map.values){
      String value = "Incorrect";
      if(rightOrWrong) {
        value = "Correct";
        score++;
      }
      rows.add(TableRow(children: [
        Container(
          child: Text("Question " + i.toString(), textAlign: TextAlign.center,),
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        Container(
          child: Text(value, textAlign: TextAlign.center),
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
      ]));
      i++;
    }
    rows.add(TableRow(children: [
      Container(
        child: Text("Total:", textAlign: TextAlign.center),
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
      Container(
        child: Text(score.toString(), textAlign: TextAlign.center),
        margin: EdgeInsets.symmetric(vertical: 10),
      ),
    ]));
    return Table(
        border: TableBorder.all(color: Colors.black),
        children: rows
    );
  }

  TeXViewWidget _teXViewWidget(String title, String question, String yourAnswer, String actualAnswer) {
    return TeXViewColumn(
        style: TeXViewStyle(
            margin: TeXViewMargin.all(8),
            padding: TeXViewPadding.all(10),
            borderRadius: TeXViewBorderRadius.all(0),
            backgroundColor: CustomColors.BlueZodiac,
            border: TeXViewBorder.all(TeXViewBorderDecoration(borderStyle: TeXViewBorderStyle.Hidden,))),
        children: [
          TeXViewDocument(title,
              style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.Left,
                  margin: TeXViewMargin.only(top: 10),
                  contentColor: Colors.white,
                  fontStyle: TeXViewFontStyle(
                      fontSize: 24,
                      fontWeight: TeXViewFontWeight.bold
                  ),
                  backgroundColor: Colors.transparent)),
          TeXViewDocument(question,
              style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.Left,
                  contentColor: Colors.white,
                  fontStyle: TeXViewFontStyle(
                    fontSize: 14
                  ),
                  margin: TeXViewMargin.only(top: 10),
                  backgroundColor: Colors.transparent)),
          TeXViewDocument("Your Answer: " + yourAnswer,
              style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.Left,
                  contentColor: Colors.white,
                  margin: TeXViewMargin.only(top: 10),
                  fontStyle: TeXViewFontStyle(
                      fontSize: 16,
                      fontWeight: TeXViewFontWeight.bold
                  ),
              )
          ),
          TeXViewDocument("Actual Answer: " + actualAnswer,
              style: TeXViewStyle(
                textAlign: TeXViewTextAlign.Left,
                contentColor: Colors.white,
                margin: TeXViewMargin.only(top: 10),
                fontStyle: TeXViewFontStyle(
                    fontSize: 16,
                    fontWeight: TeXViewFontWeight.bold
                ),
              )
          ),
        ]);
  }

  List<TeXViewWidget> answersWidget() {
    List<TeXViewWidget> widgets = [];
    for(int i = 0; i < questions.length; i++) {
      Question question = questions[i];
      String _title = "Question " + (i+1).toString();
      String _question = question.preQuestion + "\n" + question.question + question.afterQuestion;

      String _questionAnswer =  r"\[" + question.answer + r"\]";

      String _answerTemp = answers[i];
      if(_answerTemp == "") {
        _answerTemp = "n/a";
      }
      String _answer = r"\[" + _answerTemp  + r"\]";

      widgets.add(_teXViewWidget(_title , _question, _answer, _questionAnswer));
    }
    return widgets;

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "Answers",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16
                              ),
                            ),
                        ),

                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: createTable(),
                          )
                        ),
                        TeXView(
                            child: TeXViewColumn(
                              children: answersWidget()
                            )
                        )


                      ],
                    )
                )
            )
          ]
      ),
    );
  }
}