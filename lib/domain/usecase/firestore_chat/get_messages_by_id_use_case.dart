import 'package:socially/domain/entities/message_entity.dart';
import 'package:socially/domain/repositories/firestore_chat_repository.dart';

class GetMessagesByIdUseCase {
  final FirestoreChatRepository firestoreChatRepository;

  GetMessagesByIdUseCase(this.firestoreChatRepository);

  Stream<List<MessageEntity>> execute(String myPersonalId, String reciverId) {
    return firestoreChatRepository.getMessagesById(myPersonalId, reciverId);
  }
}
