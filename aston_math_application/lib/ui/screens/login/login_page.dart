import 'package:aston_math_application/ui/screens/home/home_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginPageWidget extends StatelessWidget {

  void onLogInPressed(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => HomePage(),
        ),
        ModalRoute.withName(''));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log in"),
        ),
        body: Container(
        color: Colors.white,
          child: Stack(
            children: [
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your username',
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 30, 16, 30),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your password',
                          ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      )
                    ],
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: TextButton(
                      child: Text('Log in'),
                      style: flatButtonStyle,
                      onPressed: () => onLogInPressed(context),
                    ),
                    margin: EdgeInsets.fromLTRB(16, 4, 16, 37),
                  ),
                ],
              )
            ],
          )
        )
    );
  }
}
