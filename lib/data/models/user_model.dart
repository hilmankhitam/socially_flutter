part of 'models.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final String username;
  final DateTime dateOfBirth;
  final String gender;
  final String? about;
  final String? profilePicture;
  final List<String> following;
  final List<String> follower;
  final bool isOnline;
  final DateTime lastSeen;

  const UserModel(
    this.id,
    this.email, {
    required this.username,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    this.about,
    this.profilePicture,
    this.following = const [],
    this.follower = const [],
    required this.isOnline,
    required this.lastSeen,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, String id) => UserModel(
        id,
        json['email'],
        name: json['name'],
        username: json['username'],
        dateOfBirth: DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth']),
        gender: json['gender'],
        about: json['about'],
        profilePicture: json['profilePicture'],
        following: List<String>.from(json['following'].map((x) => x)),
        follower: List<String>.from(json['follower'].map((x) => x)),
        isOnline: json['isOnline'],
        lastSeen: DateTime.fromMillisecondsSinceEpoch(json['lastSeen']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'username': username,
        'dateOfBirth': dateOfBirth.toString(),
        'gender': gender,
        'about': about,
        'profilePicture': profilePicture,
        'following': List<dynamic>.from(following.map((x) => x)),
        'follower': List<dynamic>.from(following.map((x) => x)),
      };

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      username: username,
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

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        dateOfBirth,
        gender,
        about!,
        profilePicture!,
        following,
        follower,
        isOnline,
        lastSeen,
      ];
}
