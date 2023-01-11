part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentLoadingState extends CommentState {
  @override
  List<Object?> get props => [];
}

class CommentSuccessState extends CommentState {
  final CommentEntity comment;
  final UserEntity user;

  const CommentSuccessState(this.comment, this.user);

  @override
  List<Object?> get props => [comment, user];
}

class CommentFailureState extends CommentState {
  final String message;

  const CommentFailureState(this.message);
  @override
  List<Object?> get props => [message];
}
