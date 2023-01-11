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
  bool? isOnline;
  DateTime? lastSeen;

  UserEntity({
    this.id,
    this.email,
    this.name,
    this.username,
    this.dateOfBirth,
    this.gender,
    this.about,
    this.profilePicture,
    this.following,
    this.follower,
    this.isOnline,
    this.lastSeen,
  });

  UserEntity copyWith({
    String? name,
    String? profilePicture,
    String? about,
    DateTime? dateOfBirth,
    String? username,
    List<String>? following,
    List<String>? follower,
    bool? isOnline,
    DateTime? lastSeen,
  }) =>
      UserEntity(
        id: id ?? this.name,
        email: email ?? email,
        name: name ?? this.name,
        username: username ?? this.username,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender,
        about: about ?? this.about,
        profilePicture: profilePicture ?? this.profilePicture,
        following: following ?? this.following,
        follower: follower ?? this.follower,
        isOnline: isOnline ?? this.isOnline,
        lastSeen: lastSeen ?? this.lastSeen,
      );

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
        isOnline,
        lastSeen,
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
      isOnline: isOnline!,
      lastSeen: lastSeen!,
    );
  }
}
