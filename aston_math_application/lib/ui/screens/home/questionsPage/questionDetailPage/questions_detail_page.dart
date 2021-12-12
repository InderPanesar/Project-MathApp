import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:math_keyboard/math_keyboard.dart';

class QuestionDetailPage extends StatefulWidget {

  String id, topicName;

  QuestionDetailPage({required this.id, required this.topicName});

  @override _QuestionDetailPageState createState() => _QuestionDetailPageState(id: this.id, topicName: this.topicName);
}

class _QuestionDetailPageState extends State<QuestionDetailPage> {
  QuestionDetailPageCubit _bloc = GetIt.instance();

  String id, topicName;
  _QuestionDetailPageState({required this.id, required this.topicName}) {
    _bloc.getQuestions(id);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text(topicName),
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
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                      child: BlocBuilder<QuestionDetailPageCubit, QuestionDetailPageState>(
                        bloc: _bloc,
                        builder: (context, state) {
                          if(state is QuestionDetailPageStateSuccess) {
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 200,
                                    color: Colors.black,
                                    margin: EdgeInsets.all(16),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(topicName, style: TextStyle(fontSize: 32, color: Colors.black), textAlign: TextAlign.start,),
                                        padding: EdgeInsets.all(16),
                                      ),
                                      Spacer()
                                    ],
                                  ),

                                  Container(
                                    child: Text(state.questions[0].description, style: TextStyle(fontSize: 16, color: Colors.black),),
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red),
                                          foregroundColor: MaterialStateProperty.all(Colors.white),
                                      ),
                                      onPressed: () {
                                          QuestionService service = GetIt.I();
                                          service.start(context, state.questions);
                                      },
                                      child: Text('Start Quiz'),
                                    ),
                                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                  ),

                                  Spacer(),
                                ]
                            );
                          }
                          if(state is QuestionDetailPageStateFailed) return Spacer(); //ToDo: Implement Error State
                          if (state is QuestionDetailPageStateLoading) {
                            return Center(
                                child: CircularProgressIndicator()
                            );
                          }
                          return Spacer();
                        },
                      )

                  ),
            )
        ]
    )
    );
  }
}