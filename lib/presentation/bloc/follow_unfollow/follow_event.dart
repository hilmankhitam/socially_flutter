part of 'follow_bloc.dart';

abstract class FollowUnfollowEvent extends Equatable {
  const FollowUnfollowEvent();

  @override
  List<Object> get props => [];
}

class FollowUserEvent extends FollowUnfollowEvent {
  final String myPersonalId;
  final String followingUserId;

  const FollowUserEvent(
      {required this.myPersonalId, required this.followingUserId});

  @override
  List<Object> get props => [myPersonalId, followingUserId];
}

class UnfollowUserEvent extends FollowUnfollowEvent {
  final String myPersonalId;
  final String followingUserId;

  const UnfollowUserEvent(
      {required this.myPersonalId, required this.followingUserId});

  @override
  List<Object> get props => [myPersonalId, followingUserId];
}
