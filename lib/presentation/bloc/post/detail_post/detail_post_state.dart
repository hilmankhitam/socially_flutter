part of 'detail_post_bloc.dart';

abstract class DetailPostState extends Equatable {
  const DetailPostState();
}

class DetailPostInitial extends DetailPostState {
  @override
  List<Object?> get props => [];
}

class DetailPostSuccessState extends DetailPostState {
  final UserEntity user;
  final PostEntity post;
  final List<UserEntity> likes;

  const DetailPostSuccessState(this.user, this.post, this.likes);

  @override
  List<Object?> get props => [user, post];
}

class DetailPostFailureState extends DetailPostState {
  final String message;

  const DetailPostFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailPostLoadingState extends DetailPostState {
  @override
  List<Object?> get props => [];
}
