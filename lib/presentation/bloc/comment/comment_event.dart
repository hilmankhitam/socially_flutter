part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class AddNewCommentEvent extends CommentEvent {
  final String idPost;
  final String idUser;
  final String comment;
  const AddNewCommentEvent(this.idPost, this.idUser, this.comment);

  @override
  List<Object?> get props => [idPost, idUser, comment];
}

class CommentInitialEvent extends CommentEvent {
  @override
  List<Object?> get props => [];
}
