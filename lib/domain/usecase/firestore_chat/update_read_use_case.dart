import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/repositories/firestore_chat_repository.dart';

class UpdateReadUseCase {
  final FirestoreChatRepository firestoreChatRepository;

  UpdateReadUseCase(this.firestoreChatRepository);

  Future<Either<Failure, String>> execute(
      List<MessageEntity> messages, String reciverId, String myPersonalId) {
    return firestoreChatRepository.updateRead(
        messages, reciverId, myPersonalId);
  }
}
