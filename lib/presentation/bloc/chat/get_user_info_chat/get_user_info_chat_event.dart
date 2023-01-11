part of 'get_user_info_chat_bloc.dart';

abstract class GetUserInfoChatEvent extends Equatable {
  const GetUserInfoChatEvent();
}

class GetUserInfoByIdEvent extends GetUserInfoChatEvent {
  final List<String> uids;

  const GetUserInfoByIdEvent(this.uids);
  @override
  List<Object?> get props => [uids];
}
