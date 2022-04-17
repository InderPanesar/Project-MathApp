import 'package:aston_math_application/ui/screens/home/videosPage/videos_tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/mock_api.dart';
import '../../helpers/page_setup.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await testingSetUp();
  });

  //Check that cards are shown on the home page.
  testWidgets('Title, Text-fields and Buttons Exist', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(VideosTabPage()));
      await tester.pumpAndSettle();

      final title = find.text('Videos');
      final card = find.byType(Card);
      final tab1 = find.text("VIDEOS 1");
      final tab2 = find.text("VIDEOS 2");

      expect(title, findsOneWidget);
      expect(card, findsWidgets);
      expect(tab1, findsOneWidget);
      expect(tab2, findsOneWidget);

    });
  });

}