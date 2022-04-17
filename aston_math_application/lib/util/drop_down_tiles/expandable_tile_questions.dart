import 'package:aston_math_application/engine/model/Questions/question_topic.dart';
import 'package:aston_math_application/ui/screens/authentication/login/login_page.dart';
import 'package:aston_math_application/ui/screens/authentication/register/register_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

//Expandable Tiles Widget for Questions
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
                  color: CustomColors.FunBlue,
                  child: InkWell(
                    splashColor: CustomColors.FunBlue.withAlpha(30),
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
                              Text( topic.name + " " + (i+1).toString(), style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed"),),
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
        color: CustomColors.BlueZodiac,
        child: InkWell(
          splashColor: CustomColors.BlueZodiac.withAlpha(30),
          onTap: () {
            navigateToPage(context, topic, 0);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Row(
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Icon(
                          Icons.calculate,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                    SizedBox(width: 8,),

                    Text( topic.name, style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
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
            color: CustomColors.BlueZodiac,
            child: InkWell(
              splashColor: CustomColors.BlueZodiac.withAlpha(30),
              onTap: () {
                setState(() {
                  isExpanded = !isExpanded;
                  (isExpanded) ? topRadius = BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)) : topRadius = BorderRadius.circular(10);
                  (isExpanded) ? rotation = 180 : rotation = 0;

                });
              },
              child: Padding(
                padding: EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Row(
                      children: [
                        Container(
                          child: Padding(
                            padding: EdgeInsets.zero,
                            child: Icon(
                              Icons.calculate,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        ),
                        SizedBox(width: 8,),
                        Text( topic.name, style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
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