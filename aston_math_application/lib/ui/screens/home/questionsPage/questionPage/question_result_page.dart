import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get_it/get_it.dart';
import 'package:math_keyboard/math_keyboard.dart';

class QuestionResultPage extends StatefulWidget {

  Map<Question, bool> map;
  QuestionResultPage({required this.map});

  @override _QuestionResultPageState createState() => _QuestionResultPageState(map: this.map);
}

class _QuestionResultPageState extends State<QuestionResultPage> {

  Map<Question, bool> map;
  _QuestionResultPageState({required this.map});


  Widget createTable() {
    List<TableRow> rows = [];
    int i = 1;
    int score = 0;
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
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10.0),
                          child: Center(
                            child: createTable(),
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