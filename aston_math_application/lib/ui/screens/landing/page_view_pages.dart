import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageViewPages {

  static String title = "Do quizzes";
  static String description = "Do quizzes to help you get better at the maths content need for foundation year and beyond!";


  static List<Widget> getPages() {
    return [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(title, style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text(description, style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
            ],
          )
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
              ],
            )
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.transparent,
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(fontSize: 24, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Text(description, style: TextStyle(fontSize: 12, color: Colors.black, decoration: TextDecoration.none, fontFamily: "Asap", fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
              ],
            )
        ),
      ),
    ];
  }
}