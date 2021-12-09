import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QuestionRepository {
  Future<List<Question>> getUserDetails(String id);

}

class QuestionRepositoryImpl implements QuestionRepository {

  final FirebaseFirestore _firebaseFirestore;
  QuestionRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<Question>> getUserDetails(String id) async {
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