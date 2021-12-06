import 'package:flutter/material.dart';

class SettingsTabPage extends StatefulWidget {
  @override
  _SettingsTabPageState createState() => _SettingsTabPageState();
}

class _SettingsTabPageState extends State<SettingsTabPage> {

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

              ]
          )
      ),
    );
  }
}