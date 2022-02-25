import 'package:aston_math_application/ui/screens/authentication/forgotten/forgot_password_page.dart';
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

  testWidgets('Title, Text-fields and Buttons Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(ForgotPasswordPageWidget()));
      await tester.pump();

      final title = find.text('Forgotten Password');
      final field = find.byType(TextFormField);
      final button = find.byType(ProgressButton);

      expect(title, findsOneWidget);
      expect(field, findsOneWidget);
      expect(button, findsOneWidget);

    });
  });

  testWidgets('Check Error State', (tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(PageSetup.setupPage(ForgotPasswordPageWidget()));
      await tester.pump();

      final button = find.byType(ProgressButton);
      await tester.tap(button);
      await tester.pump();

      final errorMessage = find.text("Error: " + "Error");
      expect(errorMessage, findsOneWidget);

    });
  });

  testWidgets('Check Success State', (tester) async {
    await tester.runAsync(() async {

      await tester.pumpWidget(PageSetup.setupPage(ForgotPasswordPageWidget()));
      await tester.pump();

      await tester.enterText(find.byType(TextFormField), 'email@email.com');

      final button = find.byType(ProgressButton);
      await tester.tap(button);
      await tester.pump();

      final successMessage = find.text("Check your email for a link to reset your password.");
      expect(successMessage, findsOneWidget);

    });
  });

}


