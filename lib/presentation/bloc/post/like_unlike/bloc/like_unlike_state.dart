part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();
}

class LikeUnlikeInitial extends LikeUnlikeState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LikeUnlikeSuccessState extends LikeUnlikeState {
  final String message;

  const LikeUnlikeSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class LikeUnlikeFailureState extends LikeUnlikeState {
  final String message;

  const LikeUnlikeFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
