import 'package:equatable/equatable.dart';
import 'package:socially/data/models/models.dart';

class UserEntity extends Equatable {
  String? id;
  String? email;
  String? name;
  String? username;
  DateTime? dateOfBirth;
  String? gender;
  String? about;
  String? profilePicture;
  List<String>? following;
  List<String>? follower;

  UserEntity(
    this.id,
    this.email, {
    required this.name,
    required this.username,
    required this.dateOfBirth,
    required this.gender,
    required this.about,
    required this.profilePicture,
    required this.following,
    required this.follower,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        username,
        dateOfBirth,
        gender,
        about,
        profilePicture,
        following,
        follower,
      ];

  UserModel toModel() {
    return UserModel(
      id!,
      email!,
      name: name!,
      username: username!,
      dateOfBirth: dateOfBirth!,
      gender: gender!,
      about: about!,
      profilePicture: profilePicture!,
      following: following!,
      follower: follower!,
    );
  }
}
