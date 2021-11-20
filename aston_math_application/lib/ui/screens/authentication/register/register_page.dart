import 'package:aston_math_application/ui/screens/authentication/register/registerCubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';



class RegisterPageWidget extends StatefulWidget {
  @override
  _RegisterPageWidgetState createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  ButtonState loginButtonState = ButtonState.idle;
  RegisterCubit _bloc = RegisterCubit(service: GetIt.I());
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void onLogInPressed(BuildContext context, String email, String password) {
    _bloc.signUpUser(email, password);
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
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Email',
                            ),

                          ),
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
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
                    BlocConsumer<RegisterCubit, RegisterState>(
                      bloc: _bloc,
                      listener: (context, state) {

                        if(state is RegisterStateSuccess) {
                          loginButtonState = ButtonState.idle;
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        }
                        else if(state is RegisterStateLoading) {
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
                            ButtonState.idle: Text("Sign Up",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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