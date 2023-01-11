part of 'models.dart';

class MessageModel {
  final String senderId;
  final DateTime createdAt;
  final String message;

  MessageModel({
    required this.senderId,
    required this.createdAt,
    required this.message,
  });

  MessageEntity toEntity() => MessageEntity(
        senderId: senderId,
        createdAt: createdAt,
        message: message,
      );

  factory MessageModel.fromJson(
          QueryDocumentSnapshot<Map<String, dynamic>> json) =>
      MessageModel(
        senderId: json['senderId'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'senderId': senderId,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'message': message,
      };
}
