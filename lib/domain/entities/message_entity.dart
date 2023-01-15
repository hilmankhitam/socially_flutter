import 'package:socially/data/models/models.dart';

class MessageEntity {
  String? chatId;
  String senderId;
  DateTime createdAt;
  String message;
  String chatImage;
  List<String> read;

  MessageEntity({
    this.chatId,
    required this.senderId,
    required this.createdAt,
    required this.message,
    required this.chatImage,
    required this.read,
  });

  MessageModel toModel() => MessageModel(
        chatId: chatId,
        senderId: senderId,
        createdAt: createdAt,
        message: message,
        chatImage: chatImage,
        read: read,
      );
}
