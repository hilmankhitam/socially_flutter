import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/usecase/firestore_chat/add_message_use_case.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AddMessageUseCase addMessageUseCase;

  ChatBloc({
    required this.addMessageUseCase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoadingState());

      try {
        final result =
            await addMessageUseCase.execute(event.reciverId, event.message);
        await result.fold(
          (failure) async => emit(ChatFailureState(failure.message)),
          (success) async => emit(ChatSuccessState(success)),
        );
      } catch (error) {
        emit(ChatFailureState(error.toString()));
      }
    });
  }
}
