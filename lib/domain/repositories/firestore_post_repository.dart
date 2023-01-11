import 'package:dartz/dartz.dart';
import 'package:socially/common/failure.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/post_entity.dart';

abstract class FirestorePostRepository {
  Future<Either<Failure, String>> addPost(PostEntity post);
  Future<Either<Failure, String>> updatePost(String postImage, String idPost);
  Future<Either<Failure, List<PostEntity>>> getPost(String uid);
  Future<Either<Failure, PostEntity>> getDetailPost(String idPost);
  Future<Either<Failure, CommentEntity>> addComment(
      String idPost, String idUser, String comment);
  Future<Either<Failure, List<CommentEntity>>> getAllComments(String idPost);
  Future<Either<Failure, String>> likeThisPost(String idPost, String idUser);
  Future<Either<Failure, String>> unlikeThisPost(String idPost, String idUser);
  Future<Either<Failure, List<PostEntity>>> getFeedsBasedOnFollowing(
      List<String> following, String uid);
}
