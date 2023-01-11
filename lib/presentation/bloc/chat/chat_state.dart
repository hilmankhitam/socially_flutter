part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatLoadingState extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatFailureState extends ChatState {
  final String message;

  const ChatFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

class ChatSuccessState extends ChatState {
  final String message;

  const ChatSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
