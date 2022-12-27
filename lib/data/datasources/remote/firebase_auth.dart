import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthentication {
  Future<User> signUp(String email, String password);
  Future<User> signIn(String email, String password);
  Future<String> signOut();
  Stream<User?> get userStream;
}

class FirebaseAuthenticationImpl implements FirebaseAuthentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<User> signUp(String email, String password) async {
    UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = result.user!;

    return user;
  }

  @override
  Future<User> signIn(String username, String password) async {
    QuerySnapshot snapshot =
        await _firebaseFirestore.where('username', isEqualTo: username).get();
    String? email;
    if (snapshot.docs.isEmpty) {
      email = 's@o.c';
    } else {
      email = snapshot.docs.first['email'];
    }

    UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email!, password: password);

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
