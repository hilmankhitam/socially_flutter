import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socially/domain/entities/message_data.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/usecase/firestore_chat/add_message_use_case.dart';
import 'package:socially/domain/usecase/firestore_chat/update_read_use_case.dart';
import 'package:socially/domain/usecase/storage_methods/upload_chat_image_use_case.dart';
import 'package:socially/presentation/bloc/user/user_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AddMessageUseCase addMessageUseCase;
  final UpdateReadUseCase updateReadUseCase;
  final UploadChatImageUseCase uploadChatImageUseCase;

  ChatBloc({
    required this.addMessageUseCase,
    required this.updateReadUseCase,
    required this.uploadChatImageUseCase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      emit(ChatLoadingState());

      try {
        MessageEntity message = MessageEntity(
          senderId: event.message.senderId,
          createdAt: event.message.createdAt,
          message: event.message.message,
          chatImage: '',
          read: [],
        );
        if (event.message.chatImage != null) {
          final resultUpload =
              await uploadChatImageUseCase.execute(event.message.chatImage!);
          await resultUpload.fold((failure) async => null, (downloadUrl) async {
            message.chatImage = downloadUrl;
          });
        }
        final result =
            await addMessageUseCase.execute(event.reciverId, message);
        await result.fold(
          (failure) async => emit(ChatFailureState(failure.message)),
          (success) async => emit(ChatSuccessState(success)),
        );
      } catch (error) {
        emit(ChatFailureState(error.toString()));
      }
    });

    on<UpdateReadEvent>((event, emit) async {
      try {
        if (event.messages.isNotEmpty) {
          final result = await updateReadUseCase.execute(
              event.messages, event.receiverId, event.myPersonalId);
          await result.fold(
            (_) async => null,
            (_) async => null,
          );
        }
      } catch (_) {}
    });
  }
}
