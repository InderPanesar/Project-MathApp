import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/changeDetails/change_details_page.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/openSourceLicenses/open_source_licences_page.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/settings_tab_page_cubit.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
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
                          child: Icon(Icons.settings_applications, color: Colors.white, size: 150,),
                          padding: EdgeInsets.fromLTRB(0,30,0,5)
                      ),
                      Container(
                          child: Text("Settings", style: TextStyle(fontSize: 26, color: Colors.white, fontWeight: FontWeight.bold),),
                          padding: EdgeInsets.fromLTRB(0,100,20,5)
                      ),
                      Spacer()
                    ],
                  ),
                  color: CustomColors.BlueZodiac,
                ),
                SizedBox(height: 10,),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: CustomColors.BlueZodiac,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        Row(
                          children: [
                            Text("Push Notifications", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                            Spacer(),
                            Switch(
                              value: _bloc.isPushNotificationsActive(),
                              onChanged: (bool) {
                                _bloc.updateNotificationStatus();
                                setState(() {
                                  _bloc.isPushNotificationsActive();
                                });
                              },
                              activeColor: Colors.lightGreen,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: CustomColors.BlueZodiac,
                  child: InkWell(
                    splashColor: CustomColors.BlueZodiac.withAlpha(30),
                    onTap: ()  {
                      onChangeDetails(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Row(
                            children: [
                              Text( "Change Details", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: CustomColors.BlueZodiac,
                  child: InkWell(
                    splashColor: CustomColors.BlueZodiac.withAlpha(30),
                    onTap: () async {
                      AuthenticationService service = GetIt.instance();
                      await service.signOut();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Row(
                            children: [
                              Text( "Log Out", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  color: CustomColors.BlueZodiac,
                  child: InkWell(
                    splashColor: CustomColors.BlueZodiac.withAlpha(30),
                    onTap: () async {
                      onShowOpenSourceLicenses(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          Row(
                            children: [
                              Text( "Open Source Licenses", style: TextStyle(fontSize: 20, color: Colors.white, fontFamily: "AsapCondensed", fontWeight: FontWeight.w700),),
                              Spacer(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "App Version 1.0.0",
                    style: TextStyle(fontSize: 10, color: Colors.black, fontFamily: "AsapCondensed", fontWeight: FontWeight.normal),
                  )
                )


              ]
          )
      ),
    );
  }

  void onChangeDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChangeDetailsPageWidget()),
    );
  }

  void onShowOpenSourceLicenses(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OpenSourceLicencePage()),
    );
  }
}

