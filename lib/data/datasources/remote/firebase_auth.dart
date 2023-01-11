import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthentication {
  Future<User> signUp(String email, String password);
  Future<User> signIn(String email, String password);
  Future<String> signOut();
  Stream<User?> get userStream;
}

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;

    return user;
  }

  @override
  Future<User> signIn(String email, String password) async {
    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    final user = result.user!;

    return user;
  }

  @override
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'successfully sign out';
  }

  @override
  Stream<User?> get userStream => _firebaseAuth.authStateChanges();
}
