part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUser extends UserEvent {
  final String id;

  const LoadUser(this.id);

  @override
  List<Object?> get props => [id];
}

class UpdateUser extends UserEvent {
  final String? name;
  final String? profilePicture;
  final String? about;
  final String? username;
  final List<String>? following;
  final List<String>? follower;
  final bool? isOnline;
  final DateTime? lastSeen;

  const UpdateUser({
    this.name,
    this.profilePicture,
    this.about,
    this.username,
    this.following,
    this.follower,
    this.isOnline,
    this.lastSeen,
  });

  @override
  List<Object?> get props => [
        name,
        profilePicture,
        about,
        username,
        following,
        follower,
        isOnline,
        lastSeen,
      ];
}
