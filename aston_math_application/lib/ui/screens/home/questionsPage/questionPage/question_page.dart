import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questionDetailPageCubit/questions_detail_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_page_cubit.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionPage/question_service.dart';
import 'package:dialogs/dialogs/message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get_it/get_it.dart';
import 'package:math_keyboard/math_keyboard.dart';
import 'package:easy_localization/easy_localization.dart';


class QuestionPage extends StatefulWidget {

  Question question;
  int index;

  QuestionPage({required this.question, required this.index});

  @override _QuestionPageState createState() => _QuestionPageState(QuestionPageCubit(index: index, question: question));
}

class _QuestionPageState extends State<QuestionPage> {

  String input ="";

  QuestionPageCubit cubit;
  _QuestionPageState(this.cubit);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cubit.appBarText()),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                MessageDialog messageDialog = MessageDialog(
                    dialogBackgroundColor: Colors.white,
                    buttonOkColor: Colors.red,
                    title: 'Hint',
                    titleColor: Colors.black,
                    message: 'hint_message'.tr(),
                    messageColor: Colors.black,
                    buttonOkText: 'Ok',
                    dialogRadius: 15.0,
                    buttonRadius: 18.0,
                    iconButtonOk: Icon(Icons.one_k));
                messageDialog.show(context, barrierColor: Colors.white);
              },
              icon: Icon(Icons.help),
            ),
          ],
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
                          margin: EdgeInsets.symmetric(vertical: 10),
                          height: 15,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressIndicator(
                              value: cubit.getPercentage(),
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ),
                        texView(cubit.returnQuestions()),
                        mathKeyboard(cubit.question),
                        Spacer(),
                        nextButton()
                      ],
                    )
                )
            )
          ]
        ),
    );
  }


  Widget texView(String message) {
    return TeXView(
      child: TeXViewColumn(children: [
            TeXViewDocument(message,
                style: TeXViewStyle(
                  textAlign: TeXViewTextAlign.Center,
                  contentColor: Colors.black,
                  backgroundColor: Colors.white,


                )
          )]
        ),
      style: TeXViewStyle(
        elevation: 0,
        borderRadius: TeXViewBorderRadius.all(25),
        backgroundColor: Colors.white,
        contentColor: Colors.black
      ),
    );
  }

  Widget mathKeyboard(Question question) {
    return MathField(
      keyboardType: MathKeyboardType.expression, // Specify the keyboard type (expression or number only).
      variables: question.characters, // Specify the variables the user can use (only in expression mode).
      onSubmitted: (String value) {
        print(value);
        input = value;
      }, // Respond to the user submitting their input.
      autofocus: false, // Enable or disable autofocus of the input field.
      decoration: InputDecoration(
        labelText: 'Enter your answer',
        filled: true,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget nextButton() {
    return SizedBox(
      height: 60,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black),
              foregroundColor: MaterialStateProperty.all(Colors.white),
            ),
            onPressed: () {
              cubit.goToNextPage(context, input);
            },
            child: Text(cubit.buttonText()),
          )
      )
    );
  }



}