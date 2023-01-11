part of 'detail_profile_user_bloc.dart';

abstract class DetailProfileUserState extends Equatable {
  const DetailProfileUserState();

  @override
  List<Object> get props => [];
}

class DetailProfileUserLoading extends DetailProfileUserState {}

class DetailProfileUserSuccess extends DetailProfileUserState {
  final UserEntity user;
  final List<PostEntity> posts;
  final List<UserEntity> followers;

  const DetailProfileUserSuccess(this.user, this.posts, this.followers);

  @override
  List<Object> get props => [user, posts, followers];
}

class DetailProfileUserError extends DetailProfileUserState {
  final String message;

  const DetailProfileUserError(this.message);

  @override
  List<Object> get props => [message];
}
