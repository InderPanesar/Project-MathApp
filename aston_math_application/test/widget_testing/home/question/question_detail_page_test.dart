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
      await tester.pumpWidget(PageSetup.setupPage(QuestionDetailPage(id: "1", topicName: "Question 1")));
      await tester.pumpAndSettle();

      final title = find.text("Question 1");
      final description = find.text('DESCRIPTION');
      final button = find.byType(TextButton);
      final buttonText = find.text("Start Quiz");

      expect(title, findsWidgets);
      expect(description, findsOneWidget);
      expect(button, findsOneWidget);
      expect(buttonText, findsOneWidget);

    });
  });

}