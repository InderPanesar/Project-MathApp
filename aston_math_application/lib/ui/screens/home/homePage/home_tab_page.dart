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
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../videosPage/videoPageModal/video_tab_page_modal.dart';
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

    _bloc.getAccountDetails();

    return SingleChildScrollView(

      child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(16),
          color: CustomColors.BlueZodiac,
          child: BlocBuilder<HomePageCubit, HomePageState>(
            bloc: _bloc,
            builder: (context, state) {
              if(state is HomePageStateFailed) {
                return Column(
                    children: [
                      SizedBox(height: 20,),
                      Text('An Error Occurred!', style: const TextStyle(fontSize: 20, fontFamily:"Asap", color: Colors.white)),
                      SizedBox(height: 10,),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await _bloc.getAccountDetails();
                        },
                        child: const Text('Retry', style: const TextStyle(fontSize: 20, fontFamily:"Asap", color: CustomColors.BlueZodiac)),
                      )
                    ]); //ToDo: Implement Error State
              }
              if (state is HomePageStateLoading) {
                return Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Column(
                      children: [
                        CircularProgressIndicator(color: Colors.white,),
                        SizedBox(height: 16,),
                        Text(
                          "Loading Details...",
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                  ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircularPercentIndicator(
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
                          ],
                        ),

                        Spacer(),
                        Column(
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
                              _bloc.appropriateGreeting(),
                              style: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Text(
                              details?.name ?? "",
                              style: const TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        ),
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
                    ),
                    Visibility(
                      visible: details!.doneHomeQuiz,
                      child: Text(
                        "Daily Tasks",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Visibility(
                      visible: details!.doneHomeQuiz,
                      child: Container(
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: details!.questions.length,
                          itemBuilder: (context, index) {
                            String topicName = details!.questions.keys.toList()[index];
                            String idName = details!.questions.values.toList()[index][0];
                            String isValid = details!.questions.values.toList()[index][1];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 1),
                              color: Colors.white,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () async {
                                  if(isValid == "false") {
                                    var result = await showDialog(
                                      context: context,
                                      builder: (context) =>
                                          FutureProgressDialog(
                                              _bloc.getQuestions(idName),
                                              message: Text('Getting Personalisation Questions...')
                                          ),
                                    ) as List<Question>?;

                                    if(result != null) {
                                      QuestionService service = GetIt.instance();
                                      UserDetails _temp = details!;
                                      _temp.questions.values.toList()[index][1] = "true";
                                      service.startPersonalisationQuiz(context, result, topicName, _temp);
                                    }
                                    else {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                        content: Text("Error: Unable to start personal quizzes"),
                                      ));
                                    }
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                      Row(
                                        children: [
                                          Text( topicName, style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                                          Spacer(),
                                          Checkbox(
                                            value: isValid == "true",
                                            onChanged: null,
                                            checkColor: Colors.white,
                                            fillColor: isValid == "true" ? MaterialStateProperty.all(Colors.green) : MaterialStateProperty.all(Colors.black),
                                            activeColor: Colors.green,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: details!.recommendedVideo.length == 3 && details!.doneHomeQuiz,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Recommended Video",
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 4,),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.symmetric(vertical: 6, horizontal: 1),
                            color: Colors.white,
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () async {
                                navigateToVideoModal(context, new VideoModel(title: details!.recommendedVideo[0], attributes: [details!.recommendedVideo[1], details!.recommendedVideo[2]]));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children:[
                                    Row(
                                      children: [
                                        Text( getRecommendedVideoTitle(details!), style: TextStyle(fontSize: 20, color: Colors.black, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),


                    ),


                  ],
                );


              }
              else return Spacer();

            },

          )
      ),
    );

  }

  String getRecommendedVideoTitle(UserDetails details) {
    if(details.recommendedVideo.length == 3) {
      return details.recommendedVideo[0];
    }
    return "";
  }

  String getPercentageString(UserDetails details) {
    double percentage = getPercentageNumber(details) * 100;
    return percentage.toStringAsFixed(1) + "%";
  }

  double getPercentageNumber(UserDetails details) {
    if(details.doneHomeQuiz) {
      int total = 0;
      int scores = 0;
      for(List<String> values in details.questions.values) {
        total++;
        if(values[1] == "true") scores++;
      }

      double values = scores/total;
      return values;
    }
    return 0.0;
  }

  void navigateToVideoModal(BuildContext context, VideoModel topic) {
    String url = topic.attributes.first;
    if(url != null) {
      url = YoutubePlayer.convertUrlToId(url)!;
    }
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: url,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showMaterialModalBottomSheet(
        useRootNavigator: true,
        expand: false,
        shape: RoundedRectangleBorder(  // <-- for border radius
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        enableDrag: false,
        context: context,
        builder: (context) =>
            VideoTabPageModal(video: topic, controller: _controller)
    );

  }

}