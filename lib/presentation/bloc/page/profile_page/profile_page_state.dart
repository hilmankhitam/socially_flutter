part of 'profile_page_bloc.dart';

abstract class ProfilePageState extends Equatable {
  const ProfilePageState();
}

class ProfilePageInitial extends ProfilePageState {
  @override
  List<Object?> get props => [];
}

class OnProfileProfilePage extends ProfilePageState {
  @override
  List<Object?> get props => [];
}

class OnCommentProfilePage extends ProfilePageState {
  final String idPost;
  final List<ProfilePageEvent> pop;

  const OnCommentProfilePage(this.idPost, this.pop);

  @override
  List<Object?> get props => [idPost, pop];
}
