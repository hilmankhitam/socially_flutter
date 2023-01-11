import 'dart:io';

import 'package:socially/data/datasources/remote/firestore_user.dart';
import 'package:socially/domain/entities/user_entity.dart';
import 'package:socially/common/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:socially/domain/repositories/firestore_user_repository.dart';

import '../../common/exception.dart';

class FirestoreUserRepositoryImpl implements FirestoreUserRepository {
  final FirestoreUser firestoreUser;

  FirestoreUserRepositoryImpl({required this.firestoreUser});

  @override
  Future<Either<Failure, String>> addNewUser(UserEntity user) async {
    try {
      final result = await firestoreUser.createUser(user.toModel());
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> updateUser(UserEntity updateUser) async {
    try {
      final result = await firestoreUser.updateUser(updateUser.toModel());
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final result = await firestoreUser.getUser(id);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> searchUser(String query) async {
    try {
      final result = await firestoreUser.searchUser(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> followThisUser(
      String myPersonalId, String followingUserId) async {
    try {
      final result =
          await firestoreUser.followThisUser(myPersonalId, followingUserId);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> unfollowThisUser(
      String myPersonalId, String followingUserId) async {
    try {
      final result =
          await firestoreUser.unfollowThisUser(myPersonalId, followingUserId);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failure to connect to the network'));
    }
  }
}
