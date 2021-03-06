import 'package:aston_math_application/ui/screens/authentication/login/login_page.dart';
import 'package:aston_math_application/ui/screens/authentication/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:progress_state_button/progress_button.dart';
import '../helpers/mock_api.dart';
import '../helpers/page_setup.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await testingSetUp();
  });

  //Check if widgets exist
  testWidgets('Title, Text-fields and Buttons Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(RegisterPageWidget()));
      await tester.pump();

      final title = find.text('Sign Up');
      final field = find.byType(TextFormField);
      final button = find.byType(ProgressButton);

      expect(title, findsWidgets);
      expect(field, findsWidgets);
      expect(button, findsOneWidget);

    });
  });

  //Check Ensure that general error state exists
  testWidgets('Check Error State - Sign Up', (tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(PageSetup.setupPage(RegisterPageWidget()));

      await tester.pump();

      final button = find.byType(ProgressButton);
      await tester.tap(button);
      await tester.pump();

      final errorMessage = find.text("Error: " + "Error");
      expect(errorMessage, findsOneWidget);

    });
  });

  //Check Ensure that error state exists
  testWidgets('Check Error State w/o password - Sign Up', (tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(PageSetup.setupPage(RegisterPageWidget()));

      await tester.pump();

      await tester.enterText(find.byKey(new Key('emailField')), 'email@email.com');


      final button = find.byType(ProgressButton);
      await tester.tap(button);
      await tester.pumpAndSettle();

      final errorMessage = find.text("Error: " + "Error");
      expect(errorMessage, findsOneWidget);

    });
  });

  //Check Ensure that sign up success state exists
  testWidgets('Check Success State - Sign up', (tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(PageSetup.setupPage(LoginPageWidget()));
      await tester.pump();

      await tester.enterText(find.byKey(new Key('emailField')), 'email@email.com');
      await tester.enterText(find.byKey(new Key('passwordField')), 'password');


      final button = find.byType(ProgressButton);
      await tester.tap(button);
      await tester.pumpAndSettle();

      final errorMessage = find.text("Error: " + "Error");
      expect(errorMessage, findsNothing);

    });
  });

}