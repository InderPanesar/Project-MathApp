import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/settings_tab_page_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SettingsTabPage extends StatefulWidget {
  @override
  _SettingsTabPageState createState() => _SettingsTabPageState();
}

class _SettingsTabPageState extends State<SettingsTabPage> {

  SettingsTabPageCubit _bloc = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.center,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                          child: Text("Settings", style: TextStyle(fontSize: 32, color: Colors.black),),
                          padding: EdgeInsets.fromLTRB(20,60,20,40)
                      ),
                      Spacer()
                    ],
                  ),
                  color: Colors.lightGreen,
                ),

                TextButton(
                    onPressed: () async {
                      AuthenticationService service = GetIt.instance();
                      await service.signOut();
                    },
                    child: Text("LogOut")
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: Colors.red,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Row(
                          children: [
                            Text("Push Notifications", style: TextStyle(fontSize: 20, color: Colors.white),),
                            Spacer(),
                            Switch(
                              value: _bloc.isPushNotificationsActive(),
                              onChanged: (bool) {
                                _bloc.updateNotificationStatus();
                                setState(() {
                                  _bloc.isPushNotificationsActive();
                                });
                              },
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]
          )
      ),
    );
  }
}