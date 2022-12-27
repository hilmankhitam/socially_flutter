part of 'extensions.dart';

extension FirebaseUserExtension on User {
  UserEntity convertToUser({
    String name = 'No Name',
    String username = 'username',
    DateTime? dateOfBirth,
    String gender = 'Male',
    String about = 'about',
    String profilePicture = '',
    List<String> following = const [],
    List<String> follower = const [],
  }) =>
      UserEntity(
        uid,
        email!,
        username: username,
        name: name,
        dateOfBirth: dateOfBirth ?? DateTime.now(),
        gender: gender,
        about: about,
        profilePicture: profilePicture,
        following: following,
        follower: follower,
      );
}
