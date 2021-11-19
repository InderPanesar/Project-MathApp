
import 'package:flutter/cupertino.dart';
import 'package:aston_math_application/engine/model/example/example_response.dart';
import 'package:aston_math_application/engine/repository/example_repository.dart';
import 'package:aston_math_application/ui/screens/home/home_page.dart';
import 'package:aston_math_application/util/styles/ButtonStyles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginPageWidget extends StatelessWidget {

  Future<void> onLogInPressed(BuildContext context) async {

    ExampleRepository repo = GetIt.I();
    List<ExampleResponse> films = await repo.getResponse();
    films.forEach((film) => print(film.title + '\n'));

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
                              labelText: 'Enter your email',
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

