import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/message_entity.dart';

abstract class FirestoreChatRepository {
  Future<Either<Failure, String>> sendMessage(
      String reciverId, MessageEntity message);
  Stream<List<MessageEntity>> getMessagesById(
      String myPersonalId, String reciverId);
  Stream<List<String>> getUserInfoChat(String myPersonalId);
}
