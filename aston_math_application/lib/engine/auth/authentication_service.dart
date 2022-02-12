import 'package:aston_math_application/engine/notifications/notification_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  final NotificationService _notificationService;

  AuthenticationService(this._firebaseAuth, this._notificationService);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async{
    await _notificationService.unsubscribeFromTopic();
    await _firebaseAuth.signOut();
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      return e.message ?? "";
    }
    return "Signed in";
  }

  Future<String> signUp(String email, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      return e.message ?? "";
    }
    return "Signed up";
  }

  FirebaseAuth getAuth() {
    return _firebaseAuth;
  }


}