import 'dart:io';

class RegistrationData {
  String name;
  String email;
  DateTime dateOfBirth;
  String gender;
  String about;
  String username;
  String password;
  File? profileImage;
  List<String> follower;
  List<String> following;

  RegistrationData({
    this.name = '',
    this.email = '',
    DateTime? dateOfBirth,
    this.gender = 'Male',
    this.about = '',
    this.username = '',
    this.password = '',
    this.profileImage,
    this.follower = const [],
    this.following = const [],
  }) : dateOfBirth = dateOfBirth ?? DateTime.now();
}
