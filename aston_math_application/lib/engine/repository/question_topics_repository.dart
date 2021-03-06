import 'package:aston_math_application/engine/model/Questions/question_topic.dart';
import 'package:aston_math_application/engine/model/Questions/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

//Abstract class for Question Map Repository
abstract class QuestionMapRepository {
  //Get All Questions topics.
  Future<List<QuestionTopic>> getQuestionTopics();
  //Get All Questions for a specific id.
  Future<List<Question>> getQuestions(String id);

}

//Implementation of Question Topics Repository
class QuestionMapRepositoryImpl implements QuestionMapRepository {

  final FirebaseFirestore _firebaseFirestore;
  QuestionMapRepositoryImpl(this._firebaseFirestore);

  @override
  Future<List<QuestionTopic>> getQuestionTopics() async {
    var connectivityResult = await Connectivity().checkConnectivity();// User defined class

    if (connectivityResult == ConnectivityResult.none) {
      throw Exception();
    }

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
    var connectivityResult = await Connectivity().checkConnectivity();// User defined class

    if (connectivityResult == ConnectivityResult.none) {
      return details;
    }

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