import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

abstract class FirestoreUser {
  Future<bool> userExists(String username);
  Future<String> createUser(UserModel user);
  Future<String> updateUser(UserModel user);
  Future<UserModel> getUser(String id);
  Future<List<UserModel>> searchUser(String query);
  Future<String> followThisUser(String myPersonalId, String followingUserId);
  Future<String> unfollowThisUser(String myPersonalId, String followingUserId);
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
      'dateOfBirth': user.dateOfBirth.millisecondsSinceEpoch,
      'gender': user.gender,
      'about': user.about,
      'profilePicture': user.profilePicture ?? '',
      'following': user.following,
      'follower': user.follower,
      'isOnline': user.isOnline,
      'lastSeen': user.lastSeen.millisecondsSinceEpoch,
    });

    return 'successfully create an account';
  }

  @override
  Future<bool> userExists(String username) async {
    return (await _firebaseFirestore
            .where('username', arrayContains: username)
            .get())
        .docs
        .isNotEmpty;
  }

  @override
  Future<String> updateUser(UserModel user) async {
    await _firebaseFirestore.doc(user.id).set({
      'email': user.email,
      'name': user.name,
      'username': user.username,
      'dateOfBirth': user.dateOfBirth.millisecondsSinceEpoch,
      'gender': user.gender,
      'about': user.about,
      'profilePicture': user.profilePicture ?? '',
      'following': user.following,
      'follower': user.follower,
      'isOnline': user.isOnline,
      'lastSeen': user.lastSeen.millisecondsSinceEpoch,
    });

    return 'successfully update data';
  }

  @override
  Future<UserModel> getUser(String id) async {
    DocumentSnapshot snapshot = await _firebaseFirestore.doc(id).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return UserModel.fromJson(data, id);
  }

  @override
  Future<List<UserModel>> searchUser(String query) async {
    QuerySnapshot snapshot = await _firebaseFirestore
        .where('username', isGreaterThanOrEqualTo: query)
        .get();

    return snapshot.docs.map((e) {
      Map<String, dynamic> data = e.data() as Map<String, dynamic>;
      String id = e.id;
      return UserModel.fromJson(data, id);
    }).toList();
  }

  @override
  Future<String> followThisUser(
      String myPersonalId, String followingUserId) async {
    await _firebaseFirestore.doc(followingUserId).update({
      'follower': FieldValue.arrayUnion([myPersonalId])
    });
    await _firebaseFirestore.doc(myPersonalId).update({
      'following': FieldValue.arrayUnion([followingUserId])
    });

    return 'Success follow';
  }

  @override
  Future<String> unfollowThisUser(
      String myPersonalId, String followingUserId) async {
    await _firebaseFirestore.doc(followingUserId).update({
      'follower': FieldValue.arrayRemove([myPersonalId])
    });
    await _firebaseFirestore.doc(myPersonalId).update({
      'following': FieldValue.arrayRemove([followingUserId])
    });

    return 'Success unfollow';
  }
}
