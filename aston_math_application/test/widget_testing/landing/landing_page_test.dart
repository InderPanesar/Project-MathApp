import 'package:aston_math_application/ui/screens/landing/landing_page.dart';
import 'package:flutter_test/flutter_test.dart';
import '../helpers/mock_api.dart';
import '../helpers/page_setup.dart';

//All Landing Page Tests
void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await testingSetUp();
  });

  //Test that the values are appropriate on the Landing page on UI.
  testWidgets('Landing Page App Description Values Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(LandingPageWidget()));
      await tester.pump();

      final title = find.text('Do Quizzes');
      final subtitle = find.text('Do quizzes to help you get better at the maths content need for foundation year and beyond!');

      expect(title, findsWidgets);
      expect(subtitle, findsWidgets);

    });
  });

  //Test that the values the buttons text values are correct on UI
  testWidgets('Landing Page App Description Values Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(LandingPageWidget()));
      await tester.pump();

      final logInButtonText = find.text('Sign In');
      final signInButtonText = find.text('Register');
      expect(logInButtonText, findsOneWidget);
      expect(signInButtonText, findsOneWidget);

    });
  });
}





