import 'package:aston_math_application/engine/di/dependencies.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:easy_logger/easy_logger.dart';

import 'dependencies_mock.dart';

/// **************************************************************************************************************************
///    Title: mock.dart
///    Author: FlutterFire
///    Date: 2021
///    Code version: 1.0
///    Availability: https://github.com/firebase/flutterfire/blob/master/packages/firebase_auth/firebase_auth/test/mock.dart
///    Lines: Lines 21-62 in this class
///    License: Licensed under BSD 3-Clause "New" or "Revised" License
/// **************************************************************************************************************************

typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': {},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return {
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': {},
      };
    }

    if (customHandlers != null) {
      customHandlers(call);
    }

    return null;
  });
}

Future<T> neverEndingFuture<T>() async {
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}

//Setup lines for other parts of the code
Future<void> testingSetUp() async {
  await Firebase.initializeApp();
  TestWidgetsFlutterBinding.ensureInitialized();
  DependenciesMock().setup();

  EasyLocalization.logger.enableLevels = <LevelMessages>[
    LevelMessages.error,
    LevelMessages.warning,
  ];
  await EasyLocalization.ensureInitialized();
}

