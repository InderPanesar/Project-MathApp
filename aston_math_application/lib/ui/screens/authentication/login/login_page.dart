
import 'package:aston_math_application/ui/screens/authentication/login/exampleCubit/example_cubit.dart';
import 'package:aston_math_application/ui/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';

import 'exampleCubit/example_cubit.dart';


class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  ButtonState loginButtonState = ButtonState.idle;
  ExampleCubit _bloc = ExampleCubit(repo: GetIt.I());

  void onLogInPressed(BuildContext context) {
    _bloc.getOffers();
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
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      ),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your password',
                          ),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                      )
                    ],
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BlocConsumer<ExampleCubit, ExampleState>(
                    bloc: _bloc,
                    listener: (context, state) {

                      if(state is ExampleStateSuccess) {
                        loginButtonState = ButtonState.idle;
                        final films = state.films;
                        films.forEach((film) => print(film.title + '\n'));
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                            ModalRoute.withName(''));
                      }
                      else if(state is ExampleStateLoading) {
                        setState(() {
                          loginButtonState = ButtonState.loading;
                        });
                      }
                      else {
                        setState(() {
                          loginButtonState = ButtonState.idle;
                        });                        }
                    },
                    builder: (context, state) {
                      return ProgressButton(
                        stateWidgets: {
                          ButtonState.idle: Text("Log In",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                          ButtonState.loading: Text("Loading",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                          ButtonState.fail: Text("",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                          ButtonState.success: Text("",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                        },
                        stateColors: {
                          ButtonState.idle: Colors.grey.shade400,
                          ButtonState.loading: Colors.blue.shade300,
                          ButtonState.fail: Colors.red.shade300,
                          ButtonState.success: Colors.green.shade400,
                        },
                        onPressed: () => onLogInPressed(context),
                        state: loginButtonState,
                      );
                    },
                  ),
                ],
              )
            ],
          ),
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16)
        )
    );
  }
}
