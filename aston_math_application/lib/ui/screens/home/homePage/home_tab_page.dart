import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionsTabPageCubit/questions_tab_page_cubit.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:dialogs/dialogs/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'home_page_cubit.dart';

class HomeTabPage extends StatefulWidget {
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  UserDetailsRepository repository = GetIt.I();
  QuestionMapRepository repository2 = GetIt.I();
  VideosRepository repository4 = GetIt.I();

  AuthenticationService service = GetIt.I();

  HomePageCubit _bloc = GetIt.instance();
  UserDetails? details;



  String? name;
  String? age;

  @override
  Widget build(BuildContext context) {
    ProgressDialog progressDialog = ProgressDialog(
      context: context,
      backgroundColor: CustomColors.BlueZodiac,
      textColor: Colors.white,
    );

    AlertDialog introQuestionAlert =AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 10),child:Text("Getting Intro Questions..." )),
        ],),
    );

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      color: CustomColors.BlueZodiac,
      child: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: _bloc,
        builder: (context, state) {
          if(state is HomePageStateFailed) {
            return Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  backgroundColor: Colors.white,
                ),
                onPressed: () async {
                   await _bloc.getAccountDetails();
                },
                child: const Text('Retry'),
              ),
            ); //ToDo: Implement Error State
          }
          if (state is HomePageStateLoading) {
            return Center(
                child: CircularProgressIndicator()

            );
          }

          //If Data Received
          if(state is HomePageStateSuccess) {
            details = state.details;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 25,
                  width: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: new CircularPercentIndicator(
                        radius: 75.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: getPercentageNumber(details!),
                        center: new Text(
                          getPercentageString(details!),
                          style:
                          new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.white,
                        backgroundColor: Color.fromRGBO(222, 226, 230, 0.5),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Home",
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Good Morning",
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            details?.name ?? "",
                            style: const TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    )


                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: !details!.doneHomeQuiz,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                      backgroundColor: Colors.white,
                    ),

                    onPressed: () async {
                      var result = await showDialog(
                        context: context,
                        builder: (context) =>
                            FutureProgressDialog(
                                _bloc.getIntroQuestions(),
                                message: Text('Getting Intro Questions...')
                            ),
                      ) as List<Question>?;

                      if(result != null) {
                        QuestionService service = GetIt.I();
                        service.startIntroQuiz(context, result);
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Error: Unable to start personal quizzes"),
                        ));
                      }
                    },
                    child: const Text('Do initial quiz'),
                  ),
                )

              ],
            );
          }
          else return Spacer();

        },

      )
      /*
      child:
       */
    );
  }

  String getPercentageString(UserDetails details) {
    return "n/a";
  }

  double getPercentageNumber(UserDetails details) {
    return 0.0;
  }

}