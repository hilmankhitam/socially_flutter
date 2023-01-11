import 'package:socially/data/models/comment_model.dart';

class CommentEntity {
  String? commentId;
  String? idUser;
  String? comment;
  DateTime? createdAt;

  CommentEntity({
    this.commentId,
    this.idUser,
    this.comment,
    this.createdAt,
  });

  CommentModel toModel() {
    return CommentModel(
      commentId: commentId!,
      idUser: idUser!,
      comment: comment!,
      createdAt: createdAt!,
    );
  }
}
