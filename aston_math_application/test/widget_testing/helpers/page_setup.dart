import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MockApp extends StatelessWidget {
  final Widget widget;
  MockApp(this.widget);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: EasyLocalization.of(context)!.fallbackLocale,
        supportedLocales: EasyLocalization.of(context)!.supportedLocales,
        localizationsDelegates: EasyLocalization.of(context)!.delegates,
        home: widget
    );
  }
}

class PageSetup {
  static Widget setupPage(Widget widget) {
    return EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: [Locale('en', '')],
      path: 'assets/translations', // <-- change the path of the translation files
      child: MockApp(widget),
    );
  }
}