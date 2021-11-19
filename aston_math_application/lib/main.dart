import 'package:aston_math_application/ui/screens/authentication/login/exampleCubit/example_cubit.dart';
import 'package:aston_math_application/ui/screens/landing/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_it/get_it.dart';
import 'engine/di/dependencies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Dependencies().setup();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();


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
      home: LandingPageWidget(),
    );
  }
}
