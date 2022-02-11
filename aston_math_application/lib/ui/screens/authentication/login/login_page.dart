import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';
import 'loginCubit/login_cubit.dart';



class LoginPageWidget extends StatefulWidget {
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  ButtonState loginButtonState = ButtonState.idle;
  LoginCubit _bloc = LoginCubit(service: GetIt.I());

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void onLogInPressed(BuildContext context, String email, String password) {
    _bloc.signInUser(email, password);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log in"),
          backgroundColor: Color.fromRGBO(219, 233, 247, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: Container(
        color: Color.fromRGBO(219, 233, 247, 1),
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
                          controller: emailController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                      ),
                      Container(
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),

                            labelText: 'Password',
                          ),
                          obscureText: true,
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
                  BlocConsumer<LoginCubit, LoginState>(
                    bloc: _bloc,
                    listener: (context, state) {

                      if(state is LoginStateSuccess) {
                        loginButtonState = ButtonState.idle;
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                      else if(state is LoginStateLoading) {
                        setState(() {
                          loginButtonState = ButtonState.loading;
                        });
                      }
                      else {
                        if(state is LoginStateFailed) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Error: " + state.errorMessage),
                          ));
                        }
                        setState(() {
                          loginButtonState = ButtonState.idle;
                        });
                      }
                    },
                    builder: (context, state) {
                      return Center(
                        child: ProgressButton(
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
                          onPressed: () => onLogInPressed(context, emailController.text, passwordController.text),
                          state: loginButtonState,
                        )
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
