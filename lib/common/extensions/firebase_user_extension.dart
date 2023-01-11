part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserEntity convertToUser({
    String name = 'No Name',
    String username = 'username',
    required DateTime dateOfBirth,
    String gender = 'Male',
    String about = 'about',
    String profilePicture = '',
    List<String> following = const [],
    List<String> follower = const [],
    bool isOnline = true,
    required DateTime lastSeen,
  }) =>
      UserEntity(
        id: uid,
        email: email!,
        username: username,
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        about: about,
        profilePicture: profilePicture,
        following: following,
        follower: follower,
        isOnline: isOnline,
        lastSeen: lastSeen,
      );
}
