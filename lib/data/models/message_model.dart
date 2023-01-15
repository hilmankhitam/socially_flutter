part of 'models.dart';

class MessageModel {
  final String? chatId;
  final String senderId;
  final DateTime createdAt;
  final String message;
  final String chatImage;
  final List<String> read;

  MessageModel({
    this.chatId,
    required this.senderId,
    required this.createdAt,
    required this.message,
    required this.chatImage,
    required this.read,
  });

  MessageEntity toEntity() => MessageEntity(
        chatId: chatId,
        senderId: senderId,
        createdAt: createdAt,
        message: message,
        chatImage: chatImage,
        read: read,
      );

  factory MessageModel.fromJson(
          QueryDocumentSnapshot<Map<String, dynamic>> json) =>
      MessageModel(
        chatId: json['chatId'],
        senderId: json['senderId'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        message: json['message'],
        chatImage: json['chatImage'],
        read: List<String>.from(json['read'].map((x) => x)),
      );

  Map<String, dynamic> toJson({required String chatId}) => {
        'chatId': chatId,
        'senderId': senderId,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'message': message,
        'chatImage': chatImage,
        'read': read,
      };
}
