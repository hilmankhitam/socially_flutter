import 'dart:io';

import 'package:socially/common/exception.dart';
import 'package:socially/data/datasources/remote/firestore_posts.dart';
import 'package:socially/domain/entities/comment_entity.dart';
import 'package:socially/domain/entities/post_entity.dart';
import 'package:socially/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:socially/domain/repositories/firestore_post_repository.dart';

class FirestorePostRepositoryImpl implements FirestorePostRepository {
  final FirestorePost firestorePost;

  FirestorePostRepositoryImpl({required this.firestorePost});

  @override
  Future<Either<Failure, String>> addPost(PostEntity post) async {
    try {
      final result = await firestorePost.addPost(post.toModel());
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePost(
      String postImage, String idPost) async {
    try {
      final result = await firestorePost.updatePost(postImage, idPost);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getPost(String uid) async {
    try {
      final result = await firestorePost.getPost(uid);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getDetailPost(String idPost) async {
    try {
      final result = await firestorePost.getDetailPost(idPost);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment(
      String idPost, String idUser, String comment) async {
    try {
      final result = await firestorePost.addComment(idPost, idUser, comment);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getAllComments(
      String idPost) async {
    try {
      final result = await firestorePost.getAllComments(idPost);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> likeThisPost(
      String idPost, String idUser) async {
    try {
      final result = await firestorePost.likeThisPost(idPost, idUser);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> unlikeThisPost(
      String idPost, String idUser) async {
    try {
      final result = await firestorePost.unlikeThisPost(idPost, idUser);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getFeedsBasedOnFollowing(
      List<String> following, String uid) async {
    try {
      final result =
          await firestorePost.getFeedsBasedOnFollowing(following, uid);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }
}
