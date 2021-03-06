import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questions_tab_page.dart';
import 'package:aston_math_application/ui/screens/home/settingsPage/settings_tab_page.dart';
import 'package:aston_math_application/ui/screens/home/videosPage/videos_tab_page.dart';
import 'package:aston_math_application/util/styles/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'homePage/home_tab_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final _homeScreen = GlobalKey<NavigatorState>();
  final _questionsScreen = GlobalKey<NavigatorState>();
  final _videosScreen = GlobalKey<NavigatorState>();
  final _settingsScreen = GlobalKey<NavigatorState>();

  var _pageOptions = [];

  //Allows for nested navigation in each page.
  _HomePageState() {
    _pageOptions = [
      Navigator(
        key: _homeScreen,
        onGenerateRoute: (route) => MaterialPageRoute(
          settings: route,
          builder: (context) => HomeTabPage(),
        ),
      ),
      Navigator(
        key: _questionsScreen,
        onGenerateRoute: (route) => MaterialPageRoute(
          settings: route,
          builder: (context) => QuestionTabPage(),
        ),
      ),
      Navigator(
        key: _videosScreen,
        onGenerateRoute: (route) => MaterialPageRoute(
          settings: route,
          builder: (context) => VideosTabPage(),
        ),
      ),
      Navigator(
        key: _settingsScreen,
        onGenerateRoute: (route) => MaterialPageRoute(
          settings: route,
          builder: (context) => SettingsTabPage(),
        ),
      ),


    ];
  }

  static const TextStyle optionStyle =  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Questions',
      style: optionStyle,
    ),
    Text(
      'Videos',
      style: optionStyle,
    ),
    Text(
      'Settings',
      style: optionStyle,
    ),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: getSelectedInt(_selectedIndex),
        body: _pageOptions[_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: Colors.grey[300]!,
                  hoverColor: Colors.grey[100]!,
                  gap: 8,
                  activeColor: Colors.black,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.grey[100]!,
                  color: Colors.black,
                  tabs: [
                    GButton(
                      icon: Icons.home_rounded,
                      iconColor: CustomColors.BlueZodiac,
                      iconActiveColor: CustomColors.FunBlue,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.help_center,
                      iconColor: CustomColors.BlueZodiac,
                      iconActiveColor: CustomColors.FunBlue,
                      text: 'Questions',
                    ),
                    GButton(
                      icon: Icons.video_collection,
                      iconColor: CustomColors.BlueZodiac,
                      iconActiveColor: CustomColors.FunBlue,
                      text: 'Videos',
                    ),
                    GButton(
                      icon: Icons.settings,
                      iconColor: CustomColors.BlueZodiac,
                      iconActiveColor: CustomColors.FunBlue,
                      text: 'Settings',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          )
        ),
    );
  }

  Color getSelectedInt(int? selectedIndex) {
    if(selectedIndex != null) {
      if(selectedIndex == 0) {
        return CustomColors.BlueZodiac;
      }
    }
    return Colors.white;
  }
}
