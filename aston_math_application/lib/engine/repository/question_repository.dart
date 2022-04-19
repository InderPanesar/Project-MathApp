import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Abstract class for Question Repository
abstract class QuestionRepository {
  //Get All Questions for a specific id.
  Future<List<Question>> getQuestions(String id);

}

//Implementation of Question Repository
class QuestionRepositoryImpl implements QuestionRepository {

  final FirebaseFirestore _firebaseFirestore;
  QuestionRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<Question>> getQuestions(String id) async {
    List<Question> details = [];
    await _firebaseFirestore.collection('questions').doc(id).get().then((value) {
      if(value.exists) {
        List questions = value["questions"];
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