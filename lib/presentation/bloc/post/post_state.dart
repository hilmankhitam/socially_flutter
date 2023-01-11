part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}

class PostSuccessState extends PostState {
  final String message;

  const PostSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostFailureState extends PostState {
  final String message;

  const PostFailureState(this.message);
  @override
  List<Object?> get props => [message];
}

class UpdatePostSuccessState extends PostState {
  final String message;

  const UpdatePostSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}

class GetPostsBasedFollowingSuccessState extends PostState {
  final List<PostEntity> posts;
  final List<UserEntity> users;
  final List<List<UserEntity>> likes;
  final List<List<CommentEntity>> comments;

  const GetPostsBasedFollowingSuccessState(
      this.posts, this.users, this.likes, this.comments);

  @override
  List<Object?> get props => [posts, users, likes];
}

class GetPostsBasedFollowingFailureState extends PostState {
  final String message;

  const GetPostsBasedFollowingFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetPostsBasedFollowingLoadingState extends PostState {
  @override
  List<Object?> get props => [];
}
