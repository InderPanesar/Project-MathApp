import 'package:aston_math_application/ui/screens/login/login_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPageWidget extends StatelessWidget {

  void onSignInPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
    );
  }

  void onRegisterPressed() {
    // Intentionally blank
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.only(top: 228),
            child: Text(
              "Aston Maths Application",
              //ToDo: Add default textStyle to spage. (DefaultTextStyle)
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TextButton(
                  child: Text('Sign in'),
                  style: flatButtonStyle,
                  onPressed: () => onSignInPressed(context),
                ),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              ),
              Container(
                child: TextButton(
                  child: Text('Register'),
                  style: flatButtonStyle,
                  onPressed: () => onRegisterPressed(),
                ),
                margin: EdgeInsets.fromLTRB(16, 4, 16, 37),
              )
            ],
          )
        ],
      )
    );
  }
}
