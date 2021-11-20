import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/ui/screens/home/home_page.dart';
import 'package:aston_math_application/ui/screens/landing/landing_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'engine/di/dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();

  Dependencies().setup();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en')],
        path: 'assets/translations', // <-- change the path of the translation files
        fallbackLocale: Locale('en'),
        child: MyApp()
    ),
  );

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        home: AuthenticationWrapper(),
    );


  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final user = snapshot.data;
          if(snapshot.hasData) {
            print("user is logged in");
            return HomePage();
          }
          else {
            print("user is not logged in");
            return LandingPageWidget();
          }
        }
    );
    //return LandingPageWidget();
  }

}
