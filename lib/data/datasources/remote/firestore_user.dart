import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

abstract class FirestoreUser {
  Future<bool> userExists(String username);
  Future<String> createUser(UserModel user);
}

class FirestoreUserImpl implements FirestoreUser {
  static final CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<String> createUser(UserModel user) async {
    await _firebaseFirestore.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'username': user.username,
      'dateOfBirth': user.dateOfBirth.toString(),
      'gender': user.gender,
      'about': user.about,
      'profilePicture': user.profilePicture ?? '',
      'following': user.following,
      'follower': user.follower,
    });

    return 'successfully create an account';
  }

  @override
  Future<bool> userExists(String username) async {
    return (await _firebaseFirestore
            .where('username', isEqualTo: username)
            .get())
        .docs
        .isNotEmpty;
  }
}
