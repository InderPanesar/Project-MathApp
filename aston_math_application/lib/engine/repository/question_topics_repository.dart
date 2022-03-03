import 'package:aston_math_application/engine/model/Questions/QuestionTopic.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QuestionMapRepository {
  Future<List<QuestionTopic>> getQuestionTopics();
  Future<List<Question>> getQuestions(String id);

}

class QuestionMapRepositoryImpl implements QuestionMapRepository {

  final FirebaseFirestore _firebaseFirestore;
  QuestionMapRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<QuestionTopic>> getQuestionTopics() async {
    Map<String, dynamic>? details;
    List<QuestionTopic> topics = [];
    await _firebaseFirestore.collection('question-map').doc("2x5m7WRDcjtqSCdqJg7y").get().then((value) {
      if(value.exists) {
        details = new Map<String, dynamic>.from(value["questions"]);
        for(String name in details!.keys.toList()) {
          topics.add(QuestionTopic(name: name, id: List<String>.from(details![name])));
        }
      }
    });
    topics.sort((a, b) => a.name.compareTo(b.name));
    return topics;

  }

  @override
  Future<List<Question>> getQuestions(String id) async {
    List<Question> details = [];
    await _firebaseFirestore.collection('questions').doc(id).get().then((value) {
      if(value.exists) {
        List questions = value["questions"];
        print(questions);
        for(int i = 0; i < questions.length; i++) {
          details.add(
              Question(
                  answer: value["answer"][i],
                  question: value["questions"][i],
                  preQuestion: value["pre-question"][i],
                  afterQuestion: value["after-question"][i],
                  description: value["description"],
                  characters: value["characters"][i].split(",")
              )
          );
        }
      }
    });

    return details;

  }

}