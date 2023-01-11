part of 'get_comment_bloc.dart';

abstract class GetCommentsState extends Equatable {
  const GetCommentsState();
}

class GetCommentInitial extends GetCommentsState {
  @override
  List<Object?> get props => [];
}

class GetCommentSuccessState extends GetCommentsState {
  final List<CommentEntity> comments;
  final List<UserEntity> users;
  const GetCommentSuccessState(this.comments, this.users);
  @override
  List<Object?> get props => [comments, users];
}

class GetCommentLoadingState extends GetCommentsState {
  @override
  List<Object?> get props => [];
}

class GetCommentFailureState extends GetCommentsState {
  final String message;

  const GetCommentFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
