part of 'detail_post_bloc.dart';

abstract class DetailPostEvent extends Equatable {
  const DetailPostEvent();
}

class FetchDetailPostEvent extends DetailPostEvent {
  final String idPost;

  const FetchDetailPostEvent(this.idPost);

  @override
  List<Object?> get props => [idPost];
}
