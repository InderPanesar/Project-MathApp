import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_state_button/progress_button.dart';

import 'changeDetailsCubit/change_details_cubit.dart';



class ChangeDetailsPageWidget extends StatefulWidget {
  @override
  _ChangeDetailsPageWidgetState createState() => _ChangeDetailsPageWidgetState();
}

class _ChangeDetailsPageWidgetState extends State<ChangeDetailsPageWidget> {
  ButtonState loginButtonState = ButtonState.idle;
  UserDetailsCubit _bloc = UserDetailsCubit();

  TextEditingController ageController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
                            Icons.import_contacts_rounded,
                            size: 200,
                            color: CustomColors.BlueZodiac,
                          ),
                          SizedBox(height: 16,),
                          Text(
                            'Change Details',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Container(
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Name',
                              ),
                            ),
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                          ),
                          Container(
                            child: TextFormField(
                              controller: ageController,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Age',
                              ),
                            ),
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
                          ),
                          SizedBox(height: 30,),
                          loginButton(context),
                          SizedBox(height: 40,),
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
    return BlocConsumer<UserDetailsCubit, UserDetailsState>(
      bloc: _bloc,
      listener: (context, state) {

        if(state is UserDetailsStateSuccess) {
          loginButtonState = ButtonState.idle;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Changed User Details!"),
          ));
          Navigator.of(context).pop();
        }
        else if(state is UserDetailsStateLoading) {
          setState(() {
            loginButtonState = ButtonState.loading;
          });
        }
        else {
          if(state is UserDetailsStateFailed) {
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
                ButtonState.idle: Text("Change Details",style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
              onPressed: () => onLogInPressed(context, nameController.text, ageController.text),
              state: loginButtonState,
            )
        );
      },
    );
  }
}
