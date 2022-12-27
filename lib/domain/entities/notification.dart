import 'package:socially/domain/entities/user_entity.dart';

class NotificationEntity {
  String id;
  int notificationType;
  DateTime dateTime;
  UserEntity user;

  NotificationEntity(
      {required this.id,
      required this.dateTime,
      required this.notificationType,
      required this.user});
}
