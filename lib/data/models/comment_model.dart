import 'package:equatable/equatable.dart';
import 'package:socially/domain/entities/comment_entity.dart';

class CommentModel extends Equatable {
  final String commentId;
  final String idUser;
  final String comment;
  final DateTime createdAt;

  const CommentModel({
    required this.commentId,
    required this.idUser,
    required this.comment,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        commentId: json['commentId'],
        idUser: json['idUser'],
        comment: json['comment'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      );

  CommentEntity toEntity() {
    return CommentEntity(
      commentId: commentId,
      idUser: idUser,
      comment: comment,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        commentId,
        idUser,
        comment,
        createdAt,
      ];
}
