import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream to notify about changes in authentication state
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception("Failed to sign in: $e");
    }
  }

  // Sign up with email and password
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return result.user;
    } catch (e) {
      throw Exception("Failed to sign up: $e");
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
