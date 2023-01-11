import 'dart:io';

class PostData {
  String? idUser;
  String? description;
  String? hastag;
  DateTime? datePublished;
  List<String>? likes;
  File? postImage;

  PostData({
    this.idUser,
    this.description,
    this.hastag,
    this.datePublished,
    this.likes,
    this.postImage,
  });
}
