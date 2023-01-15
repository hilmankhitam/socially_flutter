part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class SendMessageEvent extends ChatEvent {
  final String reciverId;
  final MessageData message;

  const SendMessageEvent(this.reciverId, this.message);

  @override
  List<Object?> get props => [reciverId, message];
}

class UpdateReadEvent extends ChatEvent {
  final List<MessageEntity> messages;
  final String myPersonalId;
  final String receiverId;

  const UpdateReadEvent(this.messages, this.myPersonalId, this.receiverId);

  @override
  List<Object?> get props => [messages, myPersonalId, receiverId];
}
