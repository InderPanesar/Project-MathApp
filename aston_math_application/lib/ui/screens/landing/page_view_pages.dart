import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewPages {

  static String title = "Do quizzes";
  static String description = "Do quizzes to help you get better at the maths content need for foundation year and beyond!";

  static List<String> titles = ["Do Quizzes", "Watch Videos", "Personalised For You!"];
  static List<String> descriptions = [
    "Do quizzes to help you get better at the maths content need for foundation year and beyond!",
    "Watch multiple videos on topics to help you improve your skills.",
    "Get quizzes and videos recommended to you depending on your performance!"
  ];


  static List<Widget> getPages() {
    return List.generate(
        titles.length,
            (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              width: double.infinity,
              //padding: EdgeInsets.symmetric(horizontal: 35, vertical: 4),
              child: Container(
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(titles[index], style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                      SizedBox(height: 10,),
                      Text(descriptions[index], style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none, fontFamily: "AsapCondensed", fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                    ],
                  )
              ),
            ),
        );
  }
}