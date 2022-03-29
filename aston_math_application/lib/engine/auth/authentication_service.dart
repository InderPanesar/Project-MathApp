import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:aston_math_application/engine/repository/user_details_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import '../model/UserDetails/user_details.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final NotificationService _notificationService;

  AuthenticationService(this._firebaseAuth, this._notificationService);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  final emailVerification = RegExp(r'^[a-z0-9](\.?[a-z0-9]){5,}@aston\.ac.uk$');

  Future<void> signOut() async{
    await _notificationService.unsubscribeFromTopic();
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    if(!emailVerification.hasMatch(email)) {
      return "A aston university email must be used to sign in to the application.";
    }
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      return e.message ?? "A unknown error occurred";
    }
    return "Signed in";
  }

  Future<String> signUp(String email, String password, bool notificationsActive) async {
    if(!emailVerification.hasMatch(email)) {
      return "A aston university email must be used to sign up to the application.";
    }
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then(
              (value) => createUserDetails(notificationsActive));
    } on FirebaseAuthException catch(e) {
      return e.message ?? "A unknown error occurred";
    }
    return "Signed up";
  }

  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      return e.message ?? "";
    }
    return "Email Sent";
  }

  FirebaseAuth getAuth() {
    return _firebaseAuth;
  }

  Future<void> createUserDetails(bool notificationActive) async {
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    await users.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'full_name': "",
      'age': "",
      'done_home_quiz' : false,
      'scores' : new Map(),
      'last_active' : Timestamp.fromDate(new DateTime(2000)),
      'recommendation_quiz' : new Map(),
      'recommended_video' : [],
      'notifications_active' : notificationActive
    }, SetOptions(merge: true),
    ).then((value) => print("")
    ).catchError((error) => print("Failed to merge data: $error"));
    return;
  }






}