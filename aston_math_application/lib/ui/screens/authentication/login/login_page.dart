import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';
import '../forgotten/forgot_password_page.dart';
import '../register/register_page.dart';
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
        backgroundColor: Color.fromRGBO(219, 233, 247, 1),
        appBar: AppBar(
          title: Text(""),
          backgroundColor: Color.fromRGBO(219, 233, 247, 1),
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Color.fromRGBO(219, 233, 247, 1),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Icon(
                            Icons.account_circle,
                            size: 200,
                            color: CustomColors.BlueZodiac,
                          ),
                          Text(
                            'Log In',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              key: new Key('emailField'),
                              controller: emailController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          ),
                          Container(
                            child: TextFormField(
                              key: new Key('passwordField'),
                              controller: passwordController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Password',
                              ),
                              obscureText: true,
                            ),
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                          ),
                          SizedBox(height: 30,),
                          loginButton(context),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Don't have an Account?"
                              ),
                              SizedBox(width: 8,),
                              InkWell(
                                  child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                  ),
                                  onTap: () => onRegisterPressed(context)
                              ),
                            ],
                          ),
                          SizedBox(height: 6,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                  child: Text(
                                    'Forgotten Password?',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () => onForgottenPassword(context)
                              ),
                            ],
                          )

                        ],
                      ),
                    ],
                  ),


                ],
              ),
              padding: EdgeInsets.fromLTRB(40, 0, 40, 16)
          ),
        )
    );
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterPageWidget()),
    );
  }

  void onForgottenPassword(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordPageWidget()),
    );
  }

  Widget loginButton(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
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
                ButtonState.idle: CustomColors.BlueZodiac,
                ButtonState.loading: CustomColors.BlueZodiac,
                ButtonState.fail: CustomColors.BlueZodiac,
                ButtonState.success: CustomColors.BlueZodiac,
              },
              onPressed: () => onLogInPressed(context, emailController.text, passwordController.text),
              state: loginButtonState,
            )
        );
      },
    );
  }
}
