import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QuestionMapRepository {
  Future<Map<String, dynamic>?> getUserDetails();
  Future<List<Question>> getQuestions(String id);

}

class QuestionMapRepositoryImpl implements QuestionMapRepository {

  final FirebaseFirestore _firebaseFirestore;
  QuestionMapRepositoryImpl(this._firebaseFirestore);

  @override
  Future<Map<String, dynamic>?> getUserDetails() async {
    Map<String, dynamic>? details;
    await _firebaseFirestore.collection('question-map').doc("2x5m7WRDcjtqSCdqJg7y").get().then((value) {
      if(value.exists) {
        details = new Map<String, dynamic>.from(value["questions"]);
      }
    });
    return details;

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
                  description: value["description"]
              )
          );
        }
      }
    });
    return details;

  }

}