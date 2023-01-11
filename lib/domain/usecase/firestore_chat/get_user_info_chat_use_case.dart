import 'package:socially/domain/repositories/firestore_chat_repository.dart';

class GetUserInfoChatUseCase {
  final FirestoreChatRepository firestoreChatRepository;

  GetUserInfoChatUseCase(this.firestoreChatRepository);

  Stream<List<String>> execute(String myPersonalId) {
    return firestoreChatRepository.getUserInfoChat(myPersonalId);
  }
}
