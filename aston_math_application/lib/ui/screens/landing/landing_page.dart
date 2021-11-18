import 'package:aston_math_application/ui/screens/authentication/login/login_page.dart';
import 'package:aston_math_application/ui/screens/authentication/register/register_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LandingPageWidget extends StatelessWidget {

  void onSignInPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
    );
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPageWidget()),
    );
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
              'title',
              //ToDo: Add default textStyle to spage. (DefaultTextStyle)
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black, decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ).tr(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: TextButton(
                  child: Text('signin').tr(),
                  style: flatButtonStyle,
                  onPressed: () => onSignInPressed(context),
                ),
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              ),
              Container(
                child: TextButton(
                  child: Text('Register'),
                  style: flatButtonStyle,
                  onPressed: () => onRegisterPressed(context),
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
