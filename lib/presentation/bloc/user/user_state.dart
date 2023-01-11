part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object?> get props => [];
}

class UserLoaded extends UserState {
  final UserEntity user;
  final List<PostEntity> posts;
  const UserLoaded(this.user, this.posts);
  @override
  List<Object?> get props => [user, posts];
}

class UserFailureState extends UserState {
  final String message;
  const UserFailureState(this.message);
  @override
  List<Object?> get props => [message];
}
