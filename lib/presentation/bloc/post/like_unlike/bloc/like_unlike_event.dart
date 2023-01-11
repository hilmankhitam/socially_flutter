part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
}

class LikeThisPostEvent extends LikeUnlikeEvent {
  final String idPost;
  final String idUser;

  const LikeThisPostEvent(this.idPost, this.idUser);

  @override
  List<Object?> get props => [idPost, idUser];
}

class UnlikeThisPostEvent extends LikeUnlikeEvent {
  final String idPost;
  final String idUser;

  const UnlikeThisPostEvent(this.idPost, this.idUser);

  @override
  List<Object?> get props => [idPost, idUser];
}
