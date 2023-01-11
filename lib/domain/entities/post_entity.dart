import 'package:socially/data/models/models.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/user_entity.dart';

class PostEntity {
  String? idPost;
  String idUser;
  String description;
  String hastag;
  DateTime datePublished;
  List<String> likes;
  String postImage;

  PostEntity({
    this.idPost,
    required this.idUser,
    required this.description,
    required this.hastag,
    required this.datePublished,
    required this.likes,
    required this.postImage,
  });

  PostModel toModel() {
    return PostModel(
      idPost: idPost ?? '',
      idUser: idUser,
      description: description,
      hastag: hastag,
      datePublished: datePublished,
      likes: likes,
      postImage: postImage,
    );
  }
}
