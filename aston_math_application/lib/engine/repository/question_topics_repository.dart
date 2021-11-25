import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class QuestionMapRepository {
  Future<Map<String, dynamic>?> getUserDetails();

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

}