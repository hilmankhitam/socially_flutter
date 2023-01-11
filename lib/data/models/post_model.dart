part of 'models.dart';

class PostModel extends Equatable {
  final String idPost;
  final String idUser;
  final String description;
  final String hastag;
  final DateTime datePublished;
  final List<String> likes;
  final String postImage;

  const PostModel({
    required this.idPost,
    required this.idUser,
    required this.description,
    required this.hastag,
    required this.datePublished,
    this.likes = const [],
    required this.postImage,
  });

  PostEntity toEntity() {
    return PostEntity(
      idPost: idPost,
      idUser: idUser,
      description: description,
      hastag: hastag,
      datePublished: datePublished,
      likes: likes,
      postImage: postImage,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        idPost: json['idPost'],
        idUser: json['idUser'],
        description: json['description'],
        hastag: json['hastag'],
        datePublished:
            DateTime.fromMillisecondsSinceEpoch(json['datePublished']),
        likes: List<String>.from(json['likes'].map((x) => x)),
        postImage: json['postImage'],
      );

  @override
  List<Object?> get props => [
        idPost,
        idPost,
        description,
        hastag,
        datePublished,
        likes,
        postImage,
      ];
}
