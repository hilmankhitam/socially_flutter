import 'dart:io';

class MessageData {
  String senderId;
  DateTime createdAt;
  String message;
  File? chatImage;

  MessageData({
    required this.senderId,
    required this.createdAt,
    required this.message,
    required this.chatImage,
  });
}
