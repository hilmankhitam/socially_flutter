part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final String reciverId;
  final MessageEntity message;

  const SendMessageEvent(this.reciverId, this.message);

  @override
  List<Object?> get props => [reciverId, message];
}
