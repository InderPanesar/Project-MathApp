import 'package:aston_math_application/ui/screens/home/homePage/home_tab_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/mock_api.dart';
import '../../helpers/page_setup.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await testingSetUp();
  });

  testWidgets('Title, Text-fields and Buttons Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(HomeTabPage()));
      await tester.pumpAndSettle();

      final title = find.text("Home");
      final timeOfDay = find.text("Good Morning");
      final button = find.byType(TextButton);
      final buttonText = find.text("Do initial quiz");

      expect(title, findsOneWidget);
      expect(timeOfDay, findsOneWidget);
      expect(button, findsOneWidget);
      expect(buttonText, findsOneWidget);

    });
  });

}