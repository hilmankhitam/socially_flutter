import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/repositories/firestore_chat_repository.dart';

class AddMessageUseCase {
  final FirestoreChatRepository firestoreChatRepository;

  AddMessageUseCase(this.firestoreChatRepository);

  Future<Either<Failure, String>> execute(
      String reciverId, MessageEntity message) {
    return firestoreChatRepository.sendMessage(reciverId, message);
  }
}
