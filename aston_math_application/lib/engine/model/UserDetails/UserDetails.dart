import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  UserDetails({required this.name, required this.age, required this.doneHomeQuiz, required this.scores, required this.lastActive, required this.questions });

  final String name;
  final String age;
  bool doneHomeQuiz;
  Map<String, int> scores;
  Timestamp lastActive;
  Map<String, List<String>> questions;

}