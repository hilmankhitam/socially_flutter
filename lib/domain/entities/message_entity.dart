import 'package:socially/data/models/models.dart';

class MessageEntity {
  String senderId;
  DateTime createdAt;
  String message;

  MessageEntity({
    required this.senderId,
    required this.createdAt,
    required this.message,
  });

  MessageModel toModel() => MessageModel(
        senderId: senderId,
        createdAt: createdAt,
        message: message,
      );
}
