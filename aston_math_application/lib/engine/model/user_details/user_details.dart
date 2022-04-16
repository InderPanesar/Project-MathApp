import 'package:cloud_firestore/cloud_firestore.dart';

//User Details Model defined from Firebase DB Model
class UserDetails {
  UserDetails({required this.name, required this.age, required this.doneHomeQuiz, required this.scores, required this.lastActive, required this.questions, required this.recommendedVideo, required this.notificationsActive });

  String name;
  String age;
  bool doneHomeQuiz;
  Map<String, int> scores;
  Timestamp lastActive;
  Map<String, List<String>> questions;
  List<String> recommendedVideo;
  bool notificationsActive;

}