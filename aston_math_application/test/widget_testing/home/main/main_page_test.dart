import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:aston_math_application/ui/screens/home/homePage/home_tab_page.dart';
import 'package:aston_math_application/ui/screens/home/questionsPage/questionDetailPage/questions_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import '../../helpers/mock_api.dart';
import '../../helpers/page_setup.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await testingSetUp();
  });

  testWidgets('Title, Text-fields and Buttons Exist, but no name', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(PageSetup.setupPage(HomeTabPage()));
      await tester.pumpAndSettle();

      final title = find.text("Home");
      final timeOfDay = find.text("Good Morning");
      final button = find.byType(TextButton);
      final buttonText = find.text("Do initial quiz");
      final nameText = find.text("John");

      expect(title, findsOneWidget);
      expect(timeOfDay, findsOneWidget);
      expect(button, findsOneWidget);
      expect(buttonText, findsOneWidget);
      expect(nameText, findsNothing);

    });
  });

  testWidgets('Ensure that name is now shown', (tester) async {
    await tester.runAsync(() async {
      UserDetailsRepository repo = GetIt.instance();
      UserDetails? details = await repo.getUserDetails();
      if(details == null) {
        fail("Check Repository for correct user details mocking!");
      }
      details.name = "John";
      await repo.addUserDetails(details);
      await tester.pumpWidget(PageSetup.setupPage(HomeTabPage()));
      await tester.pumpAndSettle();

      final nameText = find.text("John");
      expect(nameText, findsOneWidget);

    });
  });

  testWidgets('4 Widgets of Daily Tasks are shown, and Video Shown', (tester) async {
    await tester.runAsync(() async {
      UserDetailsRepository repo = GetIt.instance();
      UserDetails? details = await repo.getUserDetails();
      if(details == null) {
        fail("Check Repository for correct user details mocking!");
      }
      details.doneHomeQuiz = true;
      details.scores["TOPIC 1"] = 10;
      details.scores["TOPIC 2"] = 100;
      details.scores["TOPIC 3"] = 20;
      details.scores["TOPIC 4"] = 3;
      details.scores["TOPIC 5"] = 0;
      await repo.addUserDetails(details);



      await tester.pumpWidget(PageSetup.setupPage(HomeTabPage()));
      await tester.pumpAndSettle();

      final buttonText = find.text("Do initial quiz");
      final cards = find.byType(Card);
      final topicPresent1 = find.text("TOPIC 1");
      final topicShouldNotBeFound = find.text("TOPIC 2");
      final topicPresent2 = find.text("TOPIC 3");
      final topicPresent3 = find.text("TOPIC 4");
      final topicPresent4 = find.text("TOPIC 5");

      final topicForPresentedVideo = find.text("VIDEOS 1");

      expect(cards, findsWidgets);
      expect(buttonText, findsNothing);
      expect(topicShouldNotBeFound, findsNothing);
      expect(topicPresent1, findsOneWidget);
      expect(topicPresent2, findsOneWidget);
      expect(topicPresent3, findsOneWidget);
      expect(topicPresent4, findsOneWidget);
      expect(topicForPresentedVideo, findsOneWidget);


    });
  });



}