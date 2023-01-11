part of 'get_user_info_chat_bloc.dart';

abstract class GetUserInfoChatState extends Equatable {
  const GetUserInfoChatState();
}

class GetUserInfoChatInitial extends GetUserInfoChatState {
  @override
  List<Object?> get props => [];
}

class GetUserInfoChatSuccessState extends GetUserInfoChatState {
  final List<UserEntity> users;

  const GetUserInfoChatSuccessState(this.users);

  @override
  List<Object?> get props => [users];
}

class GetUserInfoChatFailureState extends GetUserInfoChatState {
  final String message;

  const GetUserInfoChatFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetUserInfoChatLoadingState extends GetUserInfoChatState {
  @override
  List<Object?> get props => [];
}
