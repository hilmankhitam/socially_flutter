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
}
