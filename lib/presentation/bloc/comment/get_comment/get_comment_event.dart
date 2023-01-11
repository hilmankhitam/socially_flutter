part of 'get_comment_bloc.dart';

abstract class GetCommentEvent extends Equatable {
  const GetCommentEvent();
}

class GetAllCommentEvent extends GetCommentEvent {
  final String idPost;

  const GetAllCommentEvent(this.idPost);
  @override
  List<Object?> get props => [idPost];
}
