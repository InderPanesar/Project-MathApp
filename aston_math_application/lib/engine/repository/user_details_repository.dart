import 'package:aston_math_application/engine/auth/authentication_service.dart';
import 'package:aston_math_application/engine/model/UserDetails/UserDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserDetailsRepository {
  Future<void> addUserDetails(UserDetails details);
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
      'age': details.age
    }, SetOptions(merge: true),
    ).then((value) => print("'full_name' & 'age' merged with existing data!")
    ).catchError((error) => print("Failed to merge data: $error"));
  }



}