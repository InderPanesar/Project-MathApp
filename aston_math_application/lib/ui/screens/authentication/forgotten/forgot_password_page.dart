import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';
import 'forgotPasswordCubit/forgot_password_cubit.dart';


class ForgotPasswordPageWidget extends StatefulWidget {
  @override
  _ForgottenPasswordWidgetState createState() => _ForgottenPasswordWidgetState();
}

class _ForgottenPasswordWidgetState extends State<ForgotPasswordPageWidget> {
  ButtonState resetButtonState = ButtonState.idle;
  ForgottenPasswordCubit _bloc = ForgottenPasswordCubit(service: GetIt.I());

  TextEditingController emailController = TextEditingController();

  void onResetPressed(BuildContext context, String email) {
    _bloc.resetPassword(email);
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
                            'Forgotten Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          ),
                          SizedBox(height: 15,),
                          loginButton(context),
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



  Widget loginButton(BuildContext context) {
    return BlocConsumer<ForgottenPasswordCubit, ForgottenPasswordState>(
      bloc: _bloc,
      listener: (context, state) {

        if(state is ForgottenPasswordStateSuccess) {
          resetButtonState = ButtonState.idle;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Check your email for a link to reset your password."),
          ));
          Navigator.of(context).pop();
        }
        else if(state is ForgottenPasswordStateLoading) {
          setState(() {
            resetButtonState = ButtonState.loading;
          });
        }
        else {
          if(state is ForgottenPasswordStateFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Error: " + state.errorMessage),
            ));
          }
          setState(() {
            resetButtonState = ButtonState.idle;
          });
        }
      },
      builder: (context, state) {
        return Center(
            child: ProgressButton(
              stateWidgets: {
                ButtonState.idle: Text("Reset Password",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
              onPressed: () => onResetPressed(context, emailController.text),
              state: resetButtonState,
            )
        );
      },
    );
  }
}
