import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Auth service which defines all the functionality for FirebaseAuth
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

  //Returns the message from Firebase Auth if error occurs.
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

  //Returns the message from Firebase Auth if error occurs.
  Future<String> signUp(String email, String password, bool notificationsActive) async {
    if(!emailVerification.hasMatch(email)) {
      return "A aston university email must be used to sign up to the application.";
    }
    try {
      //Ensures the database entry is created before sign up is completed
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

  //Get Firebase Auth Instance.
  FirebaseAuth getAuth() {
    return _firebaseAuth;
  }

  //Local instance of creating a User Details Entry with Users UID.
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