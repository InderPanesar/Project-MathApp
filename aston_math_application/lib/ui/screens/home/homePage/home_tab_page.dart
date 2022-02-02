import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/model/video/video_model.dart';
import 'package:aston_math_application/engine/repository/question_repository.dart';
import 'package:aston_math_application/engine/repository/question_topics_repository.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/engine/repository/videos_repository.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

  String? name;
  String? age;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(16),
      color: CustomColors.BlueZodiac,
      child: Column(
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
                  percent: 0.7,
                  center: new Text(
                    "70.0%",
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
                      "John",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              )


            ],
          ),


          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Age',
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              var details = UserDetails(name: nameController.text, age: ageController.text);
              print(FirebaseAuth.instance.currentUser!.uid);
              print(details.name);
              print(details.age);
              await repository.addUserDetails(details);
            },
            child: const Text('Submit'),
          ),
          Text(name ?? ""),
          Text(age ?? ""),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              var details = await repository.getUserDetails();
              if(details != null) {
                setState(() {
                  name = details.name;
                  age = details.age;
                });
              }
            },
            child: const Text('Retrieve'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              await service.signOut();
            },
            child: const Text('Logout'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              backgroundColor: Colors.white,
            ),
            onPressed: () async {
              List<VideoModel> details = await repository4.getUserDetails();

            },
            child: const Text('Hello'),
          ),
        ],
      )
    );
  }
}