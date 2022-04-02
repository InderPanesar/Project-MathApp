import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../model/user_details/user_details.dart';

abstract class UserDetailsRepository {
  Future<void> addUserDetails(UserDetails details);
  Future<UserDetails?> getUserDetails();

}

class UserDetailsRepositoryImpl implements UserDetailsRepository {

  final FirebaseFirestore _firebaseFirestore;
  final AuthenticationService _authenticationService;

  UserDetailsRepositoryImpl(this._firebaseFirestore, this._authenticationService);

  @override
  Future<void> addUserDetails(UserDetails details) async {

    CollectionReference users = _firebaseFirestore.collection('user');
    await users.doc(_authenticationService.getAuth().currentUser!.uid).set({
      'full_name': details.name,
      'age': details.age,
      'done_home_quiz' : details.doneHomeQuiz,
      'scores' : details.scores,
      'last_active' : details.lastActive,
      'recommendation_quiz' : details.questions,
      'recommended_video' : details.recommendedVideo,
      'notifications_active' : details.notificationsActive
    }, SetOptions(merge: false),
    ).then((value) => print("")
    ).catchError((error) => throw Exception());
    return;
  }

  @override
  Future<UserDetails?> getUserDetails() async {

    var connectivityResult = await Connectivity().checkConnectivity();// User defined class
    if (connectivityResult == ConnectivityResult.none) {
      return null;
    }

    UserDetails? details;
    print("UID: "+ _authenticationService.getAuth().currentUser!.uid);

    await _firebaseFirestore.collection('user').doc(_authenticationService.getAuth().currentUser!.uid).get().then((value) {
      if(value.exists) {

        Map<String, dynamic> _values = Map<String, dynamic>.from(value["scores"]);
        Map<String, int> values = {};

        for(String name in _values.keys.toList()) {
            values[name] = _values[name] as int;
        }

        Map<String, dynamic> _questions = Map<String, dynamic>.from(value["recommendation_quiz"]);
        Map<String, List<String>> questions = {};

        for(String name in _questions.keys.toList()) {
          var array = _questions[name];
          questions[name] = List<String>.from(array);
        }


        details = UserDetails(
            name: value["full_name"],
            age: value["age"],
            doneHomeQuiz: value["done_home_quiz"],
            scores: values,
            lastActive: value['last_active'] as Timestamp,
            questions: questions,
            recommendedVideo: new List<String>.from(value['recommended_video']),
            notificationsActive: value['notifications_active'] as bool
      );
      }
    }).catchError((e) {
      return null;
    });
    return details;

  }

}