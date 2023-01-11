part of 'follow_bloc.dart';

abstract class FollowUnfollowState extends Equatable {
  const FollowUnfollowState();
}

class FollowUnfollowLoadingState extends FollowUnfollowState {
  @override
  List<Object?> get props => [];
}

class FollowUnfollowErrorState extends FollowUnfollowState {
  final String message;
  const FollowUnfollowErrorState(this.message);
  @override
  List<Object?> get props => [message];
}

class FollowUnfollowSuccessState extends FollowUnfollowState {
  final String message;
  const FollowUnfollowSuccessState(this.message);
  @override
  List<Object?> get props => [message];
}
