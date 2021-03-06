import 'package:aston_math_application/ui/screens/home/homePage/home_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
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
        elevation: 0,
        centerTitle: true,
      ),
      body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Container(
                    alignment: Alignment.center,
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                    child: BlocConsumer<QuestionDetailPageCubit, QuestionDetailPageState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        if(state is QuestionDetailPageStateSuccess) {
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200,
                                  color: Colors.white,
                                  margin: EdgeInsets.all(16),
                                  child: Image.asset("assets/images/exam_image.png"),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(topicName,
                                        style: TextStyle(
                                            fontSize: 32,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                    ),
                                    Spacer()
                                  ],
                                ),

                                Container(
                                  child: Text(state.questions[0].description, style: TextStyle(fontSize: 18, color: Colors.black, fontFamily: "AsapCondensed"),),
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(CustomColors.BlueZodiac),
                                      foregroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                          )
                                      )
                                    ),
                                    onPressed: () {
                                      QuestionService service = GetIt.I();
                                      service.start(context, state.questions, topicName);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        'Start Quiz',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontFamily: "Asap",
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),



                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                                ),

                                Spacer(),
                              ]
                          );
                        }
                        else {
                          return Center(
                              child: CircularProgressIndicator( color: CustomColors.BlueZodiac,)
                          );
                        }
                        return Spacer();
                      },
                      listener: (BuildContext context, state) {
                        if(state is QuestionDetailPageStateFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error: Cannot start quiz as you currently have no Internet Connection!"),
                          ));
                          Navigator.of(context).pop();
                        }
                      },
                    )

                ),
              )
            ]
        ),
    );
  }
}