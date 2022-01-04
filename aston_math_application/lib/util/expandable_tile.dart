import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/ui/screens/authentication/login/login_page.dart';
import 'package:aston_math_application/ui/screens/authentication/register/register_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';


class ExpandableTile extends StatefulWidget {

  final QuestionTopic topic;

  ExpandableTile(this.topic);

  @override
  _ExpandableTileState createState() => _ExpandableTileState(topic);

}

class _ExpandableTileState extends State<ExpandableTile>  {

  bool isExpanded = false;
  BorderRadius topRadius = BorderRadius.circular(10.0);
  double rotation = 0;

  QuestionTopic topic;

  _ExpandableTileState(this.topic);

  void navigateToPage(BuildContext context, QuestionTopic topic, int arrayValue) {
    print('Card tapped. Code: ' + topic.id[arrayValue]);
    var detailPage = QuestionDetailPage(id: topic.id[arrayValue], topicName: topic.name,);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => detailPage),
    );
  }




  Widget getDropDown(BuildContext context, QuestionTopic topic) {
    return Visibility(
        visible: isExpanded,
        child: Column(
            children: <Widget> [
              for(int i = 0; i < topic.id.length; i++)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: ((i+1) == topic.id.length) ? BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)) : BorderRadius.circular(0),
                  ),
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
                  color: Colors.deepPurple,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      navigateToPage(context, topic, i);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Row(
                            children: [
                              Text( topic.name + " " + (i+1).toString(), style: TextStyle(fontSize: 20, color: Colors.white),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ]
        )
    );
  }

  Widget build(BuildContext context) {
    if(topic.id.length == 1) {
      return Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: topRadius,
        ),
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        color: Colors.deepPurple,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            navigateToPage(context, topic, 0);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Row(
                  children: [
                    Text( topic.name, style: TextStyle(fontSize: 20, color: Colors.white),),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    else {
      return Column(

        children: [
          SizedBox(height: 5),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: topRadius,
            ),
            clipBehavior: Clip.antiAlias,
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 12),
            color: Colors.deepPurple,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  (isExpanded) ? topRadius = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : topRadius = BorderRadius.circular(10);
                  (isExpanded) ? rotation = 180 : rotation = 0;

                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Row(
                      children: [
                        Text( topic.name, style: TextStyle(fontSize: 20, color: Colors.white),),
                        Spacer(),
                        new RotationTransition(
                          turns: new AlwaysStoppedAnimation(rotation / 360),
                          child: Container(
                            width: 20,
                            height: 20,
                            child: SvgPicture.asset(
                              "assets/images/ic_chevron-down.svg",
                              color: Colors.white,
                            ),
                          )
                        )


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          getDropDown(context, topic),
          SizedBox(height: 5),
        ],
      );
    }

  }

}