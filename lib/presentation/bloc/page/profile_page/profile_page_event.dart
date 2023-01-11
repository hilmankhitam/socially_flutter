part of 'profile_page_bloc.dart';

abstract class ProfilePageEvent extends Equatable {
  const ProfilePageEvent();
}

class GoToProfilePageInitial extends ProfilePageEvent {
  @override
  List<Object?> get props => [];
}

class GoToProfileProfilePage extends ProfilePageEvent {
  @override
  List<Object?> get props => [];
}

class GoToCommentProfilePage extends ProfilePageEvent {
  final String idPost;
  final List<ProfilePageEvent> pop;

  const GoToCommentProfilePage(this.idPost, this.pop);

  @override
  List<Object?> get props => [idPost, pop];
}
