import 'package:aston_math_application/ui/screens/authentication/register/registerCubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';

import '../../../../util/styles/CustomColors.dart';
import '../login/login_page.dart';



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
        backgroundColor: Color.fromRGBO(219, 233, 247, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(219, 233, 247, 1),
          foregroundColor: Colors.black,
          title: Text(""),
          elevation: 0,
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
                            'Sign Up',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
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
                          ),
                          SizedBox(height: 30,),
                          getRegisterButton(context),
                          SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "Have an Account?"
                              ),
                              SizedBox(width: 8,),
                              InkWell(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () => onSignInPressed(context)
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

  void onSignInPressed(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPageWidget()),
    );
  }

  Widget getRegisterButton(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
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
        return Center(
          child: ProgressButton(
            stateWidgets: {
              ButtonState.idle: Text("Sign Up",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
          ),
        );
      },
    );
  }
}