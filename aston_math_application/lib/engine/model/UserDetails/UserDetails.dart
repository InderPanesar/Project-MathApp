class UserDetails {
  UserDetails({required this.name, required this.age, required this.doneHomeQuiz, required this.scores});

  final String name;
  final String age;
  bool doneHomeQuiz;
  Map<String, int> scores;
}