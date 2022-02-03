import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDetailsRepository {
  Future<void> addUserDetails(UserDetails details);
  Future<UserDetails?> getUserDetails();

}

class UserDetailsRepositoryImpl implements UserDetailsRepository {

  final FirebaseFirestore _firebaseFirestore;
  final AuthenticationService _authenticationService;

  UserDetailsRepositoryImpl(this._firebaseFirestore, this._authenticationService);

  @override
  Future<void> addUserDetails(UserDetails details) {
    CollectionReference users = _firebaseFirestore.collection('user');
    return users.doc(_authenticationService.getAuth().currentUser!.uid).set({
      'full_name': details.name,
      'age': details.age,
      'done_home_quiz' : details.doneHomeQuiz
    }, SetOptions(merge: true),
    ).then((value) => print("'full_name' & 'age' merged with existing data!")
    ).catchError((error) => print("Failed to merge data: $error"));
  }

  @override
  Future<UserDetails?> getUserDetails() async {
    UserDetails? details;
    print("UID: "+ _authenticationService.getAuth().currentUser!.uid);
    await _firebaseFirestore.collection('user').doc(_authenticationService.getAuth().currentUser!.uid).get().then((value) {
      if(value.exists) {
        details = UserDetails(
            name: value["full_name"],
            age: value["age"],
            doneHomeQuiz: value["done_home_quiz"]
        );
      }
    });
    return details;

  }

}